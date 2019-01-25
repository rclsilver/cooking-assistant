#!/bin/bash

set -e

KUBECTL_VERSION=v1.11.1
COOKING_ASSISTANT_VERSION="$(awk '$2 == "COOKING_ASSISTANT_VERSION" { print $3; exit }' Dockerfile)"
APPLICATION_NAMESPACE="cooking-assistant"

# Push docker image
echo "${DOCKER_PASSWORD}" | docker login --username="${DOCKER_USERNAME}" --password-stdin

if [[ "${TRAVIS_BRANCH}" == "master" ]]; then
    docker tag "${IMAGE_NAME}" "${IMAGE_NAME}:latest"
    docker push "${IMAGE_NAME}:latest"
    docker tag "${IMAGE_NAME}" "${IMAGE_NAME}:${COOKING_ASSISTANT_VERSION}"
    docker push "${IMAGE_NAME}:${COOKING_ASSISTANT_VERSION}"

    container_image="${IMAGE_NAME}:${COOKING_ASSISTANT_VERSION}"
    application_namespace="${APPLICATION_NAMESPACE}"
    application_fqdn="cooking-assistant.betrancourt.net"
    cluster_issuer="letsencrypt"
    django_environment="production"
else
    docker tag "${IMAGE_NAME}" "${IMAGE_NAME}:${COOKING_ASSISTANT_VERSION}-${TRAVIS_COMMIT}"
    docker push "${IMAGE_NAME}:${COOKING_ASSISTANT_VERSION}-${TRAVIS_COMMIT}"

    container_image="${IMAGE_NAME}:${COOKING_ASSISTANT_VERSION}-${TRAVIS_COMMIT}"
    application_namespace="${APPLICATION_NAMESPACE}-$(echo ${TRAVIS_BRANCH} | tr '/' '-')"
    application_fqdn="${application_namespace}.app.rancher.ovh"
    cluster_issuer="letsencrypt" # you can use letsencrypt-staging

    if [[ "${TRAVIS_BRANCH}" =~ ^dev/ ]]; then
        django_environment=development
    elif [[ "${TRAVIS_BRANCH}" =~ ^staging/ ]]; then
        django_environment=staging
    fi
fi

if [ -z "${django_environment}" ]; then
    exit 0
fi

# Download k8s client
sudo curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl

# Configure our k8s client
mkdir ~/.kube

cat <<EOF > ~/.kube/config
apiVersion: v1
kind: Config
clusters:
- name: "default"
  cluster:
    server: "${RANCHER_SERVER_URL}"
    api-version: v1

users:
- name: "${RANCHER_USER}"
  user:
    token: "${RANCHER_TOKEN}"

contexts:
- name: "default"
  context:
    user: "${RANCHER_USER}"
    cluster: "default"

current-context: "default"
EOF

# Prepare k8s deployment
sed -ri "s#__NAMESPACE__#${application_namespace}#g" deployment/*.yaml
sed -ri "s#__CONTAINER_IMAGE__#${container_image}#g" deployment/*.yaml
sed -ri "s#__FQDN__#${application_fqdn}#g" deployment/*.yaml
sed -ri "s#__CLUSTER_ISSUER__#${cluster_issuer}#g" deployment/*.yaml
sed -ri "s#__ENVIRONMENT__#${django_environment}#g" deployment/*.yaml

# Deploy to k8s
kubectl apply -f deployment/01-namespace.yaml
kubectl apply -f deployment/02-configuration.yaml

# Clean if not master
if [[ "${TRAVIS_BRANCH}" != "master" ]]; then
    kubectl delete -f deployment/07-frontend.yaml || true
    kubectl delete -f deployment/06-celery.yaml || true
    kubectl delete -f deployment/05-rabbitmq.yaml || true
    kubectl delete -f deployment/04-psql.yaml || true
    kubectl delete -f deployment/03-volumes.yaml || true
fi

# Deploy postgresql and rabbitmq
kubectl apply -f deployment/03-volumes.yaml
kubectl apply -f deployment/04-psql.yaml
kubectl apply -f deployment/05-rabbitmq.yaml

# Deploy celery and frontend
kubectl apply -f deployment/06-celery.yaml
kubectl apply -f deployment/07-frontend.yaml
kubectl apply -f deployment/08-ingress.yaml
