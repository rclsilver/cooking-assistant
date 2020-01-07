#!/bin/bash

docker-compose -f docker-compose.tests.yml -p cooking-assistant_tests up --force-recreate --abort-on-container-exit
docker-compose -f docker-compose.tests.yml -p cooking-assistant_tests down
