--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.16
-- Dumped by pg_dump version 9.6.16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO "cooking-assistant";

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO "cooking-assistant";

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO "cooking-assistant";

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO "cooking-assistant";

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO "cooking-assistant";

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO "cooking-assistant";

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO "cooking-assistant";

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO "cooking-assistant";

--
-- Name: client; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO "cooking-assistant";

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO "cooking-assistant";

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO "cooking-assistant";

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_default_roles OWNER TO "cooking-assistant";

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO "cooking-assistant";

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO "cooking-assistant";

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO "cooking-assistant";

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO "cooking-assistant";

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO "cooking-assistant";

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO "cooking-assistant";

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO "cooking-assistant";

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO "cooking-assistant";

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO "cooking-assistant";

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO "cooking-assistant";

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO "cooking-assistant";

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO "cooking-assistant";

--
-- Name: component; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO "cooking-assistant";

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO "cooking-assistant";

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO "cooking-assistant";

--
-- Name: credential; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO "cooking-assistant";

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO "cooking-assistant";

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO "cooking-assistant";

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO "cooking-assistant";

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO "cooking-assistant";

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO "cooking-assistant";

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO "cooking-assistant";

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO "cooking-assistant";

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO "cooking-assistant";

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO "cooking-assistant";

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO "cooking-assistant";

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO "cooking-assistant";

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO "cooking-assistant";

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO "cooking-assistant";

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO "cooking-assistant";

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO "cooking-assistant";

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO "cooking-assistant";

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO "cooking-assistant";

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO "cooking-assistant";

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO "cooking-assistant";

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36),
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO "cooking-assistant";

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(36),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO "cooking-assistant";

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO "cooking-assistant";

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO "cooking-assistant";

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO "cooking-assistant";

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO "cooking-assistant";

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO "cooking-assistant";

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO "cooking-assistant";

--
-- Name: realm; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.realm OWNER TO "cooking-assistant";

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_attribute OWNER TO "cooking-assistant";

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO "cooking-assistant";

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_roles OWNER TO "cooking-assistant";

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO "cooking-assistant";

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO "cooking-assistant";

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO "cooking-assistant";

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO "cooking-assistant";

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO "cooking-assistant";

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO "cooking-assistant";

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO "cooking-assistant";

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO "cooking-assistant";

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO "cooking-assistant";

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO "cooking-assistant";

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO "cooking-assistant";

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO "cooking-assistant";

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(36) NOT NULL,
    requester character varying(36) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO "cooking-assistant";

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(36)
);


ALTER TABLE public.resource_server_policy OWNER TO "cooking-assistant";

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(36) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO "cooking-assistant";

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO "cooking-assistant";

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO "cooking-assistant";

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO "cooking-assistant";

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO "cooking-assistant";

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO "cooking-assistant";

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO "cooking-assistant";

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO "cooking-assistant";

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO "cooking-assistant";

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(36),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO "cooking-assistant";

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO "cooking-assistant";

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO "cooking-assistant";

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO "cooking-assistant";

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO "cooking-assistant";

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO "cooking-assistant";

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO "cooking-assistant";

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO "cooking-assistant";

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO "cooking-assistant";

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO "cooking-assistant";

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO "cooking-assistant";

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: cooking-assistant
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO "cooking-assistant";

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.authentication_execution VALUES ('6053c255-77a5-47c4-84d4-a4d1b520e556', NULL, 'auth-cookie', 'master', '99544bd4-9f18-4704-9791-8f7867254ef0', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0ecd8b3d-c8b6-4660-9397-9d462b5bb38d', NULL, 'auth-spnego', 'master', '99544bd4-9f18-4704-9791-8f7867254ef0', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('835a9d76-d145-4855-a492-6c39cfeada8d', NULL, 'identity-provider-redirector', 'master', '99544bd4-9f18-4704-9791-8f7867254ef0', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b6d96394-fb31-4ce6-8aca-d5daba34bba5', NULL, NULL, 'master', '99544bd4-9f18-4704-9791-8f7867254ef0', 2, 30, true, 'd94679fd-8115-4aa9-b3c8-62c819eeceed', NULL);
INSERT INTO public.authentication_execution VALUES ('b1d251cf-3aaf-40e7-9a2b-5b5980b5fc5f', NULL, 'auth-username-password-form', 'master', 'd94679fd-8115-4aa9-b3c8-62c819eeceed', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('2ad5dbe5-9223-431e-bc1a-c589c435152a', NULL, NULL, 'master', 'd94679fd-8115-4aa9-b3c8-62c819eeceed', 1, 20, true, 'e1fd1883-4915-4fcf-a9fc-98cfc7c053c5', NULL);
INSERT INTO public.authentication_execution VALUES ('9f5a148b-331c-431a-9426-f9353c7fd08a', NULL, 'conditional-user-configured', 'master', 'e1fd1883-4915-4fcf-a9fc-98cfc7c053c5', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ac32c3fe-0213-4941-97f8-e28a9d905764', NULL, 'auth-otp-form', 'master', 'e1fd1883-4915-4fcf-a9fc-98cfc7c053c5', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('bcdcb011-41de-4a85-872c-12726baa0fcd', NULL, 'direct-grant-validate-username', 'master', '9bf29e2d-70f7-4361-a9b6-e33b13f6c484', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('4f3e3ed2-229a-415d-9385-3a218559f767', NULL, 'direct-grant-validate-password', 'master', '9bf29e2d-70f7-4361-a9b6-e33b13f6c484', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5c6fc358-a601-4282-8275-47ae6ab9a1f4', NULL, NULL, 'master', '9bf29e2d-70f7-4361-a9b6-e33b13f6c484', 1, 30, true, 'e4315584-0885-4de5-b2a7-aee15a130793', NULL);
INSERT INTO public.authentication_execution VALUES ('aef94870-75bc-4da6-9921-ca1f91371fea', NULL, 'conditional-user-configured', 'master', 'e4315584-0885-4de5-b2a7-aee15a130793', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('382d56c0-45b6-417f-9052-899111ede93b', NULL, 'direct-grant-validate-otp', 'master', 'e4315584-0885-4de5-b2a7-aee15a130793', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('219babdc-4bc6-48bc-b2a0-d5ff55cc24aa', NULL, 'registration-page-form', 'master', '83f9ce39-1510-4013-b292-7440a5c6657f', 0, 10, true, 'd5a33611-632f-47e3-b414-06010e50f20d', NULL);
INSERT INTO public.authentication_execution VALUES ('b83ff5ff-f924-46b0-bd05-61a781702079', NULL, 'registration-user-creation', 'master', 'd5a33611-632f-47e3-b414-06010e50f20d', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('9968e00e-0037-4870-85d4-ca3c3bb18356', NULL, 'registration-profile-action', 'master', 'd5a33611-632f-47e3-b414-06010e50f20d', 0, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b2854cab-b694-4f2e-871d-6678f4af9d84', NULL, 'registration-password-action', 'master', 'd5a33611-632f-47e3-b414-06010e50f20d', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('af0fd60f-0618-44e6-8347-c34499349b9e', NULL, 'registration-recaptcha-action', 'master', 'd5a33611-632f-47e3-b414-06010e50f20d', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('849f775f-9d20-4aa1-bc97-5629459c5e51', NULL, 'reset-credentials-choose-user', 'master', 'fabd4128-5554-4bb0-860c-b0d45405e4f6', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('cfb1144e-67ac-464c-b8c8-068c40cd7db0', NULL, 'reset-credential-email', 'master', 'fabd4128-5554-4bb0-860c-b0d45405e4f6', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('266da6f0-8932-4f57-b178-ab2b77c7a11c', NULL, 'reset-password', 'master', 'fabd4128-5554-4bb0-860c-b0d45405e4f6', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c7db9bf4-0675-4f2c-b9e0-64b3169be892', NULL, NULL, 'master', 'fabd4128-5554-4bb0-860c-b0d45405e4f6', 1, 40, true, 'a0cb1a3a-42e1-41a1-a116-98d88fb73317', NULL);
INSERT INTO public.authentication_execution VALUES ('f7bf4240-ae4b-4fd6-b2b8-e1ee5b30271a', NULL, 'conditional-user-configured', 'master', 'a0cb1a3a-42e1-41a1-a116-98d88fb73317', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('17d5885c-f67e-4d0e-860a-7c73321aded9', NULL, 'reset-otp', 'master', 'a0cb1a3a-42e1-41a1-a116-98d88fb73317', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0da74442-0c2a-419f-837b-69f4e5804226', NULL, 'client-secret', 'master', 'c088ba32-4e55-47fc-b7bf-3ec0c75b1490', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('12ce8815-a809-4684-b12c-d84125c09168', NULL, 'client-jwt', 'master', 'c088ba32-4e55-47fc-b7bf-3ec0c75b1490', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('7c1ca9f6-8a26-462f-a913-cc98370caef0', NULL, 'client-secret-jwt', 'master', 'c088ba32-4e55-47fc-b7bf-3ec0c75b1490', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b42a1e06-3541-4efc-ba87-e73ad242488b', NULL, 'client-x509', 'master', 'c088ba32-4e55-47fc-b7bf-3ec0c75b1490', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e92ed7d7-e760-4e55-adc3-6d102f14a635', NULL, 'idp-review-profile', 'master', '6c20b373-6c30-430f-b5d5-e4cfe8fba7f2', 0, 10, false, NULL, 'a91418eb-5601-4d53-a1fd-c5a1d469da0f');
INSERT INTO public.authentication_execution VALUES ('49bcaf2a-b641-4093-aa86-bb45a02376c2', NULL, NULL, 'master', '6c20b373-6c30-430f-b5d5-e4cfe8fba7f2', 0, 20, true, '28330962-7672-474d-8965-b2988e509d6b', NULL);
INSERT INTO public.authentication_execution VALUES ('78a443cd-37ad-484a-b2dd-1274bf5ba0fa', NULL, 'idp-create-user-if-unique', 'master', '28330962-7672-474d-8965-b2988e509d6b', 2, 10, false, NULL, '2174ff93-b912-4ed2-bb57-34511943b584');
INSERT INTO public.authentication_execution VALUES ('b02d300f-fda9-4dde-b050-0b52b59462c1', NULL, NULL, 'master', '28330962-7672-474d-8965-b2988e509d6b', 2, 20, true, '85646cc0-d793-4988-9844-770d2cb72ea2', NULL);
INSERT INTO public.authentication_execution VALUES ('165f59f2-3246-4759-9fc0-936fd16edf0b', NULL, 'idp-confirm-link', 'master', '85646cc0-d793-4988-9844-770d2cb72ea2', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('cb099e7d-5872-44c6-a7d0-d10055ded870', NULL, NULL, 'master', '85646cc0-d793-4988-9844-770d2cb72ea2', 0, 20, true, '1e632c46-4f7e-49a1-81c9-05415847c1ac', NULL);
INSERT INTO public.authentication_execution VALUES ('9bcc79aa-a490-4983-93b1-234bab59ae0d', NULL, 'idp-email-verification', 'master', '1e632c46-4f7e-49a1-81c9-05415847c1ac', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e09d4ac4-0eec-4737-8b98-13ed607f74bb', NULL, NULL, 'master', '1e632c46-4f7e-49a1-81c9-05415847c1ac', 2, 20, true, '031a1e18-e7be-4e69-8711-c69fd22a78c5', NULL);
INSERT INTO public.authentication_execution VALUES ('3105b60b-c4db-4f4c-98c9-7c12ddc8c2b0', NULL, 'idp-username-password-form', 'master', '031a1e18-e7be-4e69-8711-c69fd22a78c5', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('90a2ab7b-d9d5-48bd-ad60-bd14cf62dd7a', NULL, NULL, 'master', '031a1e18-e7be-4e69-8711-c69fd22a78c5', 1, 20, true, '8e527426-e9d2-4e3c-a768-b900e1cbaf16', NULL);
INSERT INTO public.authentication_execution VALUES ('81f29ce6-8a60-4bbb-8417-e76b82155a1b', NULL, 'conditional-user-configured', 'master', '8e527426-e9d2-4e3c-a768-b900e1cbaf16', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('9eccab43-74a3-480d-a37f-bb7e65e07463', NULL, 'auth-otp-form', 'master', '8e527426-e9d2-4e3c-a768-b900e1cbaf16', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('1be83526-1775-4ddc-b68c-ce367530c69c', NULL, 'http-basic-authenticator', 'master', '67a6716d-4914-475c-9b3a-76a31b856973', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('18a43da7-9282-4aac-983f-4ba34ad1eb8c', NULL, 'docker-http-basic-authenticator', 'master', '31a3af24-3c87-4ef3-bede-fe32b73b530f', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c029141c-a64c-4695-b511-2bf3bb85f452', NULL, 'no-cookie-redirect', 'master', '5b3b0194-b8e0-44cc-b3c7-38a392ee88ff', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e8390c43-2336-4dba-8e60-1aa79453adda', NULL, NULL, 'master', '5b3b0194-b8e0-44cc-b3c7-38a392ee88ff', 0, 20, true, 'bedd3142-0df0-4bff-aa83-97b5e12fa323', NULL);
INSERT INTO public.authentication_execution VALUES ('85a44bad-669a-4743-a037-3ead39e4868f', NULL, 'basic-auth', 'master', 'bedd3142-0df0-4bff-aa83-97b5e12fa323', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('fd184fef-d6c9-4655-8ed8-6e5baa349965', NULL, 'basic-auth-otp', 'master', 'bedd3142-0df0-4bff-aa83-97b5e12fa323', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('32a3f449-8b9a-4f55-b020-c2484202d4ae', NULL, 'auth-spnego', 'master', 'bedd3142-0df0-4bff-aa83-97b5e12fa323', 3, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('02803f44-14dd-4237-a733-f562caf91341', NULL, 'auth-cookie', 'my_realm', '14945055-57a6-475b-9300-509bcf3add0a', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('246fad57-9ef9-4a06-a950-00995edda7b1', NULL, 'auth-spnego', 'my_realm', '14945055-57a6-475b-9300-509bcf3add0a', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('24e9f21d-7297-41d6-9bcb-45850f74d6b6', NULL, 'identity-provider-redirector', 'my_realm', '14945055-57a6-475b-9300-509bcf3add0a', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('d7180401-c349-4ee2-b094-aa7db978c445', NULL, NULL, 'my_realm', '14945055-57a6-475b-9300-509bcf3add0a', 2, 30, true, '4e3cf5b3-66bf-465e-8a95-9cd7e8d8793c', NULL);
INSERT INTO public.authentication_execution VALUES ('02a8e4e7-49e3-4f55-b4d3-d66887064ee2', NULL, 'auth-username-password-form', 'my_realm', '4e3cf5b3-66bf-465e-8a95-9cd7e8d8793c', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6550471a-b6a3-4c24-863b-d0f04b56115a', NULL, NULL, 'my_realm', '4e3cf5b3-66bf-465e-8a95-9cd7e8d8793c', 1, 20, true, '5a50aabe-706c-45f8-ab3f-abda98c325ef', NULL);
INSERT INTO public.authentication_execution VALUES ('a19e3d4f-8e4a-49fa-bc46-c6f4a13fc778', NULL, 'conditional-user-configured', 'my_realm', '5a50aabe-706c-45f8-ab3f-abda98c325ef', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6b7c96ed-cae0-42d6-abed-923f4c60ea22', NULL, 'auth-otp-form', 'my_realm', '5a50aabe-706c-45f8-ab3f-abda98c325ef', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5539f861-0707-4309-af40-5ecce6c432ef', NULL, 'direct-grant-validate-username', 'my_realm', 'e4feb7bf-e017-4d64-8a58-b0ca85c57777', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('83f53d7f-1f92-4e1b-91de-76efe6767494', NULL, 'direct-grant-validate-password', 'my_realm', 'e4feb7bf-e017-4d64-8a58-b0ca85c57777', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('69f71b98-08f4-472a-bd81-19f9c5dac6f4', NULL, NULL, 'my_realm', 'e4feb7bf-e017-4d64-8a58-b0ca85c57777', 1, 30, true, '210135ac-98d9-4d6d-a6c6-7d4f26b39a42', NULL);
INSERT INTO public.authentication_execution VALUES ('0b31b73d-ee7e-4ebb-8a77-833d8c95aece', NULL, 'conditional-user-configured', 'my_realm', '210135ac-98d9-4d6d-a6c6-7d4f26b39a42', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('a71ff7ee-5df1-49e7-a2ff-48d889fb6487', NULL, 'direct-grant-validate-otp', 'my_realm', '210135ac-98d9-4d6d-a6c6-7d4f26b39a42', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('80b88046-c11b-42c1-81a9-468d826e0537', NULL, 'registration-page-form', 'my_realm', 'd2648224-61a1-499a-89c5-89a9505bf4d2', 0, 10, true, 'c09a4a64-0b41-47b3-b037-ed4508fec748', NULL);
INSERT INTO public.authentication_execution VALUES ('1902fba2-c5d1-452d-a320-800b5bdfc98b', NULL, 'registration-user-creation', 'my_realm', 'c09a4a64-0b41-47b3-b037-ed4508fec748', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('f8e6d09a-d40c-48b3-984c-65c2f539f90a', NULL, 'registration-profile-action', 'my_realm', 'c09a4a64-0b41-47b3-b037-ed4508fec748', 0, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('02b23919-5051-4bc7-8d23-541a576b633b', NULL, 'registration-password-action', 'my_realm', 'c09a4a64-0b41-47b3-b037-ed4508fec748', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e14a665d-3e15-42ab-85c7-e5a6d9b3a666', NULL, 'registration-recaptcha-action', 'my_realm', 'c09a4a64-0b41-47b3-b037-ed4508fec748', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('23df896b-25c1-44d6-8d9a-be107fc37725', NULL, 'reset-credentials-choose-user', 'my_realm', '864f918f-c701-4f48-92fb-6a26a949113b', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6ebffb03-6718-4f51-99da-0eef6b10b2c1', NULL, 'reset-credential-email', 'my_realm', '864f918f-c701-4f48-92fb-6a26a949113b', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('de415288-f407-45a4-a9cd-6a8544880d99', NULL, 'reset-password', 'my_realm', '864f918f-c701-4f48-92fb-6a26a949113b', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('536c5591-2601-43fd-99cf-b14313543ce6', NULL, NULL, 'my_realm', '864f918f-c701-4f48-92fb-6a26a949113b', 1, 40, true, 'b9d55894-4145-4305-9d0f-1cd92d375820', NULL);
INSERT INTO public.authentication_execution VALUES ('301f6a0c-058b-459c-9bfe-03106998950f', NULL, 'conditional-user-configured', 'my_realm', 'b9d55894-4145-4305-9d0f-1cd92d375820', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0e903f2f-23a9-4ee5-8712-756348478702', NULL, 'reset-otp', 'my_realm', 'b9d55894-4145-4305-9d0f-1cd92d375820', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('f6808ebd-5adc-46db-b76c-011be5144f81', NULL, 'client-secret', 'my_realm', 'a909ec97-4ba9-445e-9ba5-1765cf5c36bc', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('a9af7aed-af55-403b-927d-a9190aa6f3b7', NULL, 'client-jwt', 'my_realm', 'a909ec97-4ba9-445e-9ba5-1765cf5c36bc', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('9f59429c-43cc-40ba-9bdf-84ada52bc904', NULL, 'client-secret-jwt', 'my_realm', 'a909ec97-4ba9-445e-9ba5-1765cf5c36bc', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('8a377dc2-9b85-4a8c-9f47-2251c171fd38', NULL, 'client-x509', 'my_realm', 'a909ec97-4ba9-445e-9ba5-1765cf5c36bc', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('7493086b-f73d-4330-8d3b-4a828f863932', NULL, 'idp-review-profile', 'my_realm', '531b6e15-5581-4417-99e4-d9fd9dbf2514', 0, 10, false, NULL, '26850489-2c4b-4112-8d0c-6ab79f1512fa');
INSERT INTO public.authentication_execution VALUES ('826086a9-4a5d-47c2-b607-cd1e4bb0d09c', NULL, NULL, 'my_realm', '531b6e15-5581-4417-99e4-d9fd9dbf2514', 0, 20, true, '5393a710-3c6a-47d3-91bf-3e21d6b41ba0', NULL);
INSERT INTO public.authentication_execution VALUES ('ccff5dbf-22ec-4f92-bb58-892ab77a4f4e', NULL, 'idp-create-user-if-unique', 'my_realm', '5393a710-3c6a-47d3-91bf-3e21d6b41ba0', 2, 10, false, NULL, '7b1b3296-aa34-4c52-8b4a-0a04ef98661b');
INSERT INTO public.authentication_execution VALUES ('c1d4e9c3-2261-4c8a-802b-4db65558db33', NULL, NULL, 'my_realm', '5393a710-3c6a-47d3-91bf-3e21d6b41ba0', 2, 20, true, 'd7e0b88b-fb59-4fc4-b718-068eb442a5fd', NULL);
INSERT INTO public.authentication_execution VALUES ('7cb183e9-5d7b-4153-bea8-38b9100e4e81', NULL, 'idp-confirm-link', 'my_realm', 'd7e0b88b-fb59-4fc4-b718-068eb442a5fd', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('072856e1-a5b5-400f-98d5-373ece77e48b', NULL, NULL, 'my_realm', 'd7e0b88b-fb59-4fc4-b718-068eb442a5fd', 0, 20, true, 'c8a5ef47-c23d-482b-af64-64df43bc657d', NULL);
INSERT INTO public.authentication_execution VALUES ('9a6b9735-e651-4901-b7fd-b0369d8356b6', NULL, 'idp-email-verification', 'my_realm', 'c8a5ef47-c23d-482b-af64-64df43bc657d', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('08b55b57-85d4-41d6-887b-6196613620ba', NULL, NULL, 'my_realm', 'c8a5ef47-c23d-482b-af64-64df43bc657d', 2, 20, true, '2a329420-da3a-4a00-91a0-8a654d6c9ec9', NULL);
INSERT INTO public.authentication_execution VALUES ('3adc153f-bd94-4ce2-bb82-8214701352e6', NULL, 'idp-username-password-form', 'my_realm', '2a329420-da3a-4a00-91a0-8a654d6c9ec9', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c8cc3bca-6e48-497e-91b0-0a25ab434e54', NULL, NULL, 'my_realm', '2a329420-da3a-4a00-91a0-8a654d6c9ec9', 1, 20, true, 'd197fabc-7a7c-4a80-bf4b-53fd377fb922', NULL);
INSERT INTO public.authentication_execution VALUES ('65893cb3-f9cc-4ff0-b497-b4079beba617', NULL, 'conditional-user-configured', 'my_realm', 'd197fabc-7a7c-4a80-bf4b-53fd377fb922', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('a7dbef11-3d55-4536-b8bb-a697977a1382', NULL, 'auth-otp-form', 'my_realm', 'd197fabc-7a7c-4a80-bf4b-53fd377fb922', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('f32f86e9-2b55-4368-8afd-1bb99e81aba7', NULL, 'http-basic-authenticator', 'my_realm', 'fdc5f65d-2bff-4008-8bbf-ae188fe2909a', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('14627894-1472-438d-bbd7-865cb251136a', NULL, 'docker-http-basic-authenticator', 'my_realm', '1e784c99-a87a-440f-9dc0-9dfe2f3cb913', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ab83e721-c01b-4e5e-a991-b96709e6e61f', NULL, 'no-cookie-redirect', 'my_realm', '7bf97aa2-9d6a-4255-b911-35f974249a50', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0c21f6e3-b186-4c2e-a8a9-1165df15aa70', NULL, NULL, 'my_realm', '7bf97aa2-9d6a-4255-b911-35f974249a50', 0, 20, true, 'a3b00f34-3292-4aad-a097-b4e1bfd17e2f', NULL);
INSERT INTO public.authentication_execution VALUES ('3604c712-a432-46f4-aa5c-c5552fbc528a', NULL, 'basic-auth', 'my_realm', 'a3b00f34-3292-4aad-a097-b4e1bfd17e2f', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('732b3e8c-6f59-4b0b-ae26-17ac1d755c65', NULL, 'basic-auth-otp', 'my_realm', 'a3b00f34-3292-4aad-a097-b4e1bfd17e2f', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e2b0e8dc-d674-4603-b196-5c55b4b13125', NULL, 'auth-spnego', 'my_realm', 'a3b00f34-3292-4aad-a097-b4e1bfd17e2f', 3, 30, false, NULL, NULL);


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.authentication_flow VALUES ('99544bd4-9f18-4704-9791-8f7867254ef0', 'browser', 'browser based authentication', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('d94679fd-8115-4aa9-b3c8-62c819eeceed', 'forms', 'Username, password, otp and other auth forms.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('e1fd1883-4915-4fcf-a9fc-98cfc7c053c5', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('9bf29e2d-70f7-4361-a9b6-e33b13f6c484', 'direct grant', 'OpenID Connect Resource Owner Grant', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('e4315584-0885-4de5-b2a7-aee15a130793', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('83f9ce39-1510-4013-b292-7440a5c6657f', 'registration', 'registration flow', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('d5a33611-632f-47e3-b414-06010e50f20d', 'registration form', 'registration form', 'master', 'form-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('fabd4128-5554-4bb0-860c-b0d45405e4f6', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('a0cb1a3a-42e1-41a1-a116-98d88fb73317', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('c088ba32-4e55-47fc-b7bf-3ec0c75b1490', 'clients', 'Base authentication for clients', 'master', 'client-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('6c20b373-6c30-430f-b5d5-e4cfe8fba7f2', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('28330962-7672-474d-8965-b2988e509d6b', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('85646cc0-d793-4988-9844-770d2cb72ea2', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('1e632c46-4f7e-49a1-81c9-05415847c1ac', 'Account verification options', 'Method with which to verity the existing account', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('031a1e18-e7be-4e69-8711-c69fd22a78c5', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('8e527426-e9d2-4e3c-a768-b900e1cbaf16', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('67a6716d-4914-475c-9b3a-76a31b856973', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('31a3af24-3c87-4ef3-bede-fe32b73b530f', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('5b3b0194-b8e0-44cc-b3c7-38a392ee88ff', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('bedd3142-0df0-4bff-aa83-97b5e12fa323', 'Authentication Options', 'Authentication options.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('14945055-57a6-475b-9300-509bcf3add0a', 'browser', 'browser based authentication', 'my_realm', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('4e3cf5b3-66bf-465e-8a95-9cd7e8d8793c', 'forms', 'Username, password, otp and other auth forms.', 'my_realm', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('5a50aabe-706c-45f8-ab3f-abda98c325ef', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'my_realm', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('e4feb7bf-e017-4d64-8a58-b0ca85c57777', 'direct grant', 'OpenID Connect Resource Owner Grant', 'my_realm', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('210135ac-98d9-4d6d-a6c6-7d4f26b39a42', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'my_realm', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('d2648224-61a1-499a-89c5-89a9505bf4d2', 'registration', 'registration flow', 'my_realm', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('c09a4a64-0b41-47b3-b037-ed4508fec748', 'registration form', 'registration form', 'my_realm', 'form-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('864f918f-c701-4f48-92fb-6a26a949113b', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'my_realm', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('b9d55894-4145-4305-9d0f-1cd92d375820', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'my_realm', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('a909ec97-4ba9-445e-9ba5-1765cf5c36bc', 'clients', 'Base authentication for clients', 'my_realm', 'client-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('531b6e15-5581-4417-99e4-d9fd9dbf2514', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'my_realm', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('5393a710-3c6a-47d3-91bf-3e21d6b41ba0', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'my_realm', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('d7e0b88b-fb59-4fc4-b718-068eb442a5fd', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'my_realm', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('c8a5ef47-c23d-482b-af64-64df43bc657d', 'Account verification options', 'Method with which to verity the existing account', 'my_realm', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('2a329420-da3a-4a00-91a0-8a654d6c9ec9', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'my_realm', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('d197fabc-7a7c-4a80-bf4b-53fd377fb922', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'my_realm', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('fdc5f65d-2bff-4008-8bbf-ae188fe2909a', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'my_realm', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('1e784c99-a87a-440f-9dc0-9dfe2f3cb913', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'my_realm', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('7bf97aa2-9d6a-4255-b911-35f974249a50', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'my_realm', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('a3b00f34-3292-4aad-a097-b4e1bfd17e2f', 'Authentication Options', 'Authentication options.', 'my_realm', 'basic-flow', false, true);


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.authenticator_config VALUES ('a91418eb-5601-4d53-a1fd-c5a1d469da0f', 'review profile config', 'master');
INSERT INTO public.authenticator_config VALUES ('2174ff93-b912-4ed2-bb57-34511943b584', 'create unique user config', 'master');
INSERT INTO public.authenticator_config VALUES ('26850489-2c4b-4112-8d0c-6ab79f1512fa', 'review profile config', 'my_realm');
INSERT INTO public.authenticator_config VALUES ('7b1b3296-aa34-4c52-8b4a-0a04ef98661b', 'create unique user config', 'my_realm');


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.authenticator_config_entry VALUES ('a91418eb-5601-4d53-a1fd-c5a1d469da0f', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry VALUES ('2174ff93-b912-4ed2-bb57-34511943b584', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry VALUES ('26850489-2c4b-4112-8d0c-6ab79f1512fa', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry VALUES ('7b1b3296-aa34-4c52-8b4a-0a04ef98661b', 'false', 'require.password.update.after.registration');


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.client VALUES ('07604804-df43-4293-803b-f657b7d5b96e', true, true, 'master-realm', 0, false, 'e5ecfbba-a1a4-41cc-bce7-b27c4655c122', NULL, true, NULL, false, 'master', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false);
INSERT INTO public.client VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', true, false, 'account', 0, false, '98b570f6-175e-47f8-a601-a426a0babfc3', '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false);
INSERT INTO public.client VALUES ('90897f16-ce38-498b-abd0-df1a0f83b6db', true, false, 'broker', 0, false, '9f8f1ca5-8b7f-4d1f-b506-cc6dc8ff2c91', NULL, false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false);
INSERT INTO public.client VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', true, false, 'security-admin-console', 0, true, '3a14b0d0-86d0-472b-a674-10ec14a70c0d', '/admin/master/console/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false);
INSERT INTO public.client VALUES ('9a0ce398-6127-49f3-a16e-5aa9ea48eb00', true, false, 'admin-cli', 0, true, '70e38bee-a161-4b1c-9523-6daa880b354b', NULL, false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true);
INSERT INTO public.client VALUES ('cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, true, 'my_realm-realm', 0, false, '9d54326f-a102-41d3-b3ea-918cd27e18ed', NULL, true, NULL, false, 'master', NULL, 0, false, false, 'my_realm Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false);
INSERT INTO public.client VALUES ('9186b3e7-e5e7-4f08-8505-570149b2e740', true, false, 'realm-management', 0, false, '2c41bd37-cae0-4b6c-bd99-50393f5f4049', NULL, true, NULL, false, 'my_realm', 'openid-connect', 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false);
INSERT INTO public.client VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', true, false, 'account', 0, false, '1ec37b8a-0eba-49d8-9c1d-d637264436a7', '/realms/my_realm/account/', false, NULL, false, 'my_realm', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false);
INSERT INTO public.client VALUES ('d997ff0b-7e46-4cac-9945-b7f070c09e77', true, false, 'broker', 0, false, '28a87bf8-c5d9-4588-88fd-7dbfef2cb9bf', NULL, false, NULL, false, 'my_realm', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false);
INSERT INTO public.client VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', true, false, 'security-admin-console', 0, true, '29140a7b-f09b-4a77-bd62-4b9b5945991f', '/admin/my_realm/console/', false, NULL, false, 'my_realm', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false);
INSERT INTO public.client VALUES ('2e3752f9-bdc5-43f8-a221-c4ac3ad005b1', true, false, 'admin-cli', 0, true, 'ccd6497b-e702-4524-8ed0-a4db4437805b', NULL, false, NULL, false, 'my_realm', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true);
INSERT INTO public.client VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', true, true, 'cooking-assistant', 0, false, 'a5c8113d-01d4-4d92-8413-cae738ecdf8c', NULL, false, 'http://gw2sdev-docker.ovh.net:36610', false, 'my_realm', 'openid-connect', -1, false, false, NULL, false, 'client-secret', 'http://gw2sdev-docker.ovh.net:36610', NULL, NULL, true, false, true);


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'saml.server.signature');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'saml.assertion.signature');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'saml.client.signature');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'saml.encrypt');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'saml.authnstatement');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'saml.onetimeuse.condition');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'saml_force_name_id_format');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'saml.multivalued.roles');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'saml.force.post.binding');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'exclude.session.state.from.auth.response');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'tls.client.certificate.bound.access.tokens');
INSERT INTO public.client_attributes VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'false', 'display.on.consent.screen');


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.client_default_roles VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', 'fc1cd5e9-44de-48f2-83cb-69fec15ec0d5');
INSERT INTO public.client_default_roles VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', '403e3cc6-7fe6-4e7d-b48e-8f585781adc6');
INSERT INTO public.client_default_roles VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', 'ea65a121-b1a6-4cff-a916-7b9c710ea7cf');
INSERT INTO public.client_default_roles VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', '46a226ad-497e-44a9-8ed6-ee91c7b87c4e');


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.client_scope VALUES ('910c03d1-2a03-42e6-9acf-0314ea147127', 'offline_access', 'master', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope VALUES ('68572a70-8caa-4133-ab6d-6ee4cc4fc823', 'role_list', 'master', 'SAML role list', 'saml');
INSERT INTO public.client_scope VALUES ('a62a2286-17be-4c14-9f0e-95b674e68d35', 'profile', 'master', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope VALUES ('44902f57-993d-4987-9e63-c98ff9fd0d2f', 'email', 'master', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope VALUES ('cefa2dca-d8a1-4d58-9715-b1fedb03cf2f', 'address', 'master', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope VALUES ('6dfef3b0-6fe1-4a76-afa5-bccb894006f7', 'phone', 'master', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope VALUES ('68eabe34-176c-4075-a9aa-bf373f064ba0', 'roles', 'master', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95', 'web-origins', 'master', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd', 'microprofile-jwt', 'master', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope VALUES ('5af6c506-33c5-4ece-9f32-b24e7b5fff0e', 'offline_access', 'my_realm', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope VALUES ('d0935e0d-5613-4699-976e-dce6aaa735d5', 'role_list', 'my_realm', 'SAML role list', 'saml');
INSERT INTO public.client_scope VALUES ('602f1759-5b71-4507-8fe1-c394ec186ac0', 'profile', 'my_realm', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope VALUES ('53cb249b-316a-461b-81bc-43f02f3b643f', 'email', 'my_realm', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope VALUES ('74927a2e-4aaf-4666-ba11-7356382bacad', 'address', 'my_realm', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope VALUES ('b2ca3287-fa66-4708-b3fa-1d98a47fbd88', 'phone', 'my_realm', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope VALUES ('1a58966d-0df4-469b-b05f-a0a57c9e3588', 'roles', 'my_realm', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('4ad5b5d0-53e8-4681-827c-95d193f27949', 'web-origins', 'my_realm', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('b923fc2d-1f91-47dc-9eb6-a3683edde275', 'microprofile-jwt', 'my_realm', 'Microprofile - JWT built-in scope', 'openid-connect');


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.client_scope_attributes VALUES ('910c03d1-2a03-42e6-9acf-0314ea147127', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('910c03d1-2a03-42e6-9acf-0314ea147127', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('68572a70-8caa-4133-ab6d-6ee4cc4fc823', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('68572a70-8caa-4133-ab6d-6ee4cc4fc823', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('a62a2286-17be-4c14-9f0e-95b674e68d35', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('a62a2286-17be-4c14-9f0e-95b674e68d35', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('a62a2286-17be-4c14-9f0e-95b674e68d35', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('44902f57-993d-4987-9e63-c98ff9fd0d2f', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('44902f57-993d-4987-9e63-c98ff9fd0d2f', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('44902f57-993d-4987-9e63-c98ff9fd0d2f', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('cefa2dca-d8a1-4d58-9715-b1fedb03cf2f', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('cefa2dca-d8a1-4d58-9715-b1fedb03cf2f', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('cefa2dca-d8a1-4d58-9715-b1fedb03cf2f', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('6dfef3b0-6fe1-4a76-afa5-bccb894006f7', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('6dfef3b0-6fe1-4a76-afa5-bccb894006f7', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('6dfef3b0-6fe1-4a76-afa5-bccb894006f7', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('68eabe34-176c-4075-a9aa-bf373f064ba0', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('68eabe34-176c-4075-a9aa-bf373f064ba0', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('68eabe34-176c-4075-a9aa-bf373f064ba0', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('5af6c506-33c5-4ece-9f32-b24e7b5fff0e', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('5af6c506-33c5-4ece-9f32-b24e7b5fff0e', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('d0935e0d-5613-4699-976e-dce6aaa735d5', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('d0935e0d-5613-4699-976e-dce6aaa735d5', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('602f1759-5b71-4507-8fe1-c394ec186ac0', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('602f1759-5b71-4507-8fe1-c394ec186ac0', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('602f1759-5b71-4507-8fe1-c394ec186ac0', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('53cb249b-316a-461b-81bc-43f02f3b643f', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('53cb249b-316a-461b-81bc-43f02f3b643f', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('53cb249b-316a-461b-81bc-43f02f3b643f', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('74927a2e-4aaf-4666-ba11-7356382bacad', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('74927a2e-4aaf-4666-ba11-7356382bacad', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('74927a2e-4aaf-4666-ba11-7356382bacad', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('b2ca3287-fa66-4708-b3fa-1d98a47fbd88', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('b2ca3287-fa66-4708-b3fa-1d98a47fbd88', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('b2ca3287-fa66-4708-b3fa-1d98a47fbd88', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('1a58966d-0df4-469b-b05f-a0a57c9e3588', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('1a58966d-0df4-469b-b05f-a0a57c9e3588', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('1a58966d-0df4-469b-b05f-a0a57c9e3588', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('4ad5b5d0-53e8-4681-827c-95d193f27949', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('4ad5b5d0-53e8-4681-827c-95d193f27949', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('4ad5b5d0-53e8-4681-827c-95d193f27949', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('b923fc2d-1f91-47dc-9eb6-a3683edde275', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('b923fc2d-1f91-47dc-9eb6-a3683edde275', 'true', 'include.in.token.scope');


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.client_scope_client VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', '68572a70-8caa-4133-ab6d-6ee4cc4fc823', true);
INSERT INTO public.client_scope_client VALUES ('9a0ce398-6127-49f3-a16e-5aa9ea48eb00', '68572a70-8caa-4133-ab6d-6ee4cc4fc823', true);
INSERT INTO public.client_scope_client VALUES ('90897f16-ce38-498b-abd0-df1a0f83b6db', '68572a70-8caa-4133-ab6d-6ee4cc4fc823', true);
INSERT INTO public.client_scope_client VALUES ('07604804-df43-4293-803b-f657b7d5b96e', '68572a70-8caa-4133-ab6d-6ee4cc4fc823', true);
INSERT INTO public.client_scope_client VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', '68572a70-8caa-4133-ab6d-6ee4cc4fc823', true);
INSERT INTO public.client_scope_client VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', 'a62a2286-17be-4c14-9f0e-95b674e68d35', true);
INSERT INTO public.client_scope_client VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', '44902f57-993d-4987-9e63-c98ff9fd0d2f', true);
INSERT INTO public.client_scope_client VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', '68eabe34-176c-4075-a9aa-bf373f064ba0', true);
INSERT INTO public.client_scope_client VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', 'a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95', true);
INSERT INTO public.client_scope_client VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', '910c03d1-2a03-42e6-9acf-0314ea147127', false);
INSERT INTO public.client_scope_client VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', 'cefa2dca-d8a1-4d58-9715-b1fedb03cf2f', false);
INSERT INTO public.client_scope_client VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', '6dfef3b0-6fe1-4a76-afa5-bccb894006f7', false);
INSERT INTO public.client_scope_client VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', 'c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd', false);
INSERT INTO public.client_scope_client VALUES ('9a0ce398-6127-49f3-a16e-5aa9ea48eb00', 'a62a2286-17be-4c14-9f0e-95b674e68d35', true);
INSERT INTO public.client_scope_client VALUES ('9a0ce398-6127-49f3-a16e-5aa9ea48eb00', '44902f57-993d-4987-9e63-c98ff9fd0d2f', true);
INSERT INTO public.client_scope_client VALUES ('9a0ce398-6127-49f3-a16e-5aa9ea48eb00', '68eabe34-176c-4075-a9aa-bf373f064ba0', true);
INSERT INTO public.client_scope_client VALUES ('9a0ce398-6127-49f3-a16e-5aa9ea48eb00', 'a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95', true);
INSERT INTO public.client_scope_client VALUES ('9a0ce398-6127-49f3-a16e-5aa9ea48eb00', '910c03d1-2a03-42e6-9acf-0314ea147127', false);
INSERT INTO public.client_scope_client VALUES ('9a0ce398-6127-49f3-a16e-5aa9ea48eb00', 'cefa2dca-d8a1-4d58-9715-b1fedb03cf2f', false);
INSERT INTO public.client_scope_client VALUES ('9a0ce398-6127-49f3-a16e-5aa9ea48eb00', '6dfef3b0-6fe1-4a76-afa5-bccb894006f7', false);
INSERT INTO public.client_scope_client VALUES ('9a0ce398-6127-49f3-a16e-5aa9ea48eb00', 'c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd', false);
INSERT INTO public.client_scope_client VALUES ('90897f16-ce38-498b-abd0-df1a0f83b6db', 'a62a2286-17be-4c14-9f0e-95b674e68d35', true);
INSERT INTO public.client_scope_client VALUES ('90897f16-ce38-498b-abd0-df1a0f83b6db', '44902f57-993d-4987-9e63-c98ff9fd0d2f', true);
INSERT INTO public.client_scope_client VALUES ('90897f16-ce38-498b-abd0-df1a0f83b6db', '68eabe34-176c-4075-a9aa-bf373f064ba0', true);
INSERT INTO public.client_scope_client VALUES ('90897f16-ce38-498b-abd0-df1a0f83b6db', 'a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95', true);
INSERT INTO public.client_scope_client VALUES ('90897f16-ce38-498b-abd0-df1a0f83b6db', '910c03d1-2a03-42e6-9acf-0314ea147127', false);
INSERT INTO public.client_scope_client VALUES ('90897f16-ce38-498b-abd0-df1a0f83b6db', 'cefa2dca-d8a1-4d58-9715-b1fedb03cf2f', false);
INSERT INTO public.client_scope_client VALUES ('90897f16-ce38-498b-abd0-df1a0f83b6db', '6dfef3b0-6fe1-4a76-afa5-bccb894006f7', false);
INSERT INTO public.client_scope_client VALUES ('90897f16-ce38-498b-abd0-df1a0f83b6db', 'c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd', false);
INSERT INTO public.client_scope_client VALUES ('07604804-df43-4293-803b-f657b7d5b96e', 'a62a2286-17be-4c14-9f0e-95b674e68d35', true);
INSERT INTO public.client_scope_client VALUES ('07604804-df43-4293-803b-f657b7d5b96e', '44902f57-993d-4987-9e63-c98ff9fd0d2f', true);
INSERT INTO public.client_scope_client VALUES ('07604804-df43-4293-803b-f657b7d5b96e', '68eabe34-176c-4075-a9aa-bf373f064ba0', true);
INSERT INTO public.client_scope_client VALUES ('07604804-df43-4293-803b-f657b7d5b96e', 'a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95', true);
INSERT INTO public.client_scope_client VALUES ('07604804-df43-4293-803b-f657b7d5b96e', '910c03d1-2a03-42e6-9acf-0314ea147127', false);
INSERT INTO public.client_scope_client VALUES ('07604804-df43-4293-803b-f657b7d5b96e', 'cefa2dca-d8a1-4d58-9715-b1fedb03cf2f', false);
INSERT INTO public.client_scope_client VALUES ('07604804-df43-4293-803b-f657b7d5b96e', '6dfef3b0-6fe1-4a76-afa5-bccb894006f7', false);
INSERT INTO public.client_scope_client VALUES ('07604804-df43-4293-803b-f657b7d5b96e', 'c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd', false);
INSERT INTO public.client_scope_client VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', 'a62a2286-17be-4c14-9f0e-95b674e68d35', true);
INSERT INTO public.client_scope_client VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', '44902f57-993d-4987-9e63-c98ff9fd0d2f', true);
INSERT INTO public.client_scope_client VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', '68eabe34-176c-4075-a9aa-bf373f064ba0', true);
INSERT INTO public.client_scope_client VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', 'a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95', true);
INSERT INTO public.client_scope_client VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', '910c03d1-2a03-42e6-9acf-0314ea147127', false);
INSERT INTO public.client_scope_client VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', 'cefa2dca-d8a1-4d58-9715-b1fedb03cf2f', false);
INSERT INTO public.client_scope_client VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', '6dfef3b0-6fe1-4a76-afa5-bccb894006f7', false);
INSERT INTO public.client_scope_client VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', 'c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd', false);
INSERT INTO public.client_scope_client VALUES ('cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', '68572a70-8caa-4133-ab6d-6ee4cc4fc823', true);
INSERT INTO public.client_scope_client VALUES ('cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', 'a62a2286-17be-4c14-9f0e-95b674e68d35', true);
INSERT INTO public.client_scope_client VALUES ('cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', '44902f57-993d-4987-9e63-c98ff9fd0d2f', true);
INSERT INTO public.client_scope_client VALUES ('cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', '68eabe34-176c-4075-a9aa-bf373f064ba0', true);
INSERT INTO public.client_scope_client VALUES ('cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', 'a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95', true);
INSERT INTO public.client_scope_client VALUES ('cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', '910c03d1-2a03-42e6-9acf-0314ea147127', false);
INSERT INTO public.client_scope_client VALUES ('cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', 'cefa2dca-d8a1-4d58-9715-b1fedb03cf2f', false);
INSERT INTO public.client_scope_client VALUES ('cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', '6dfef3b0-6fe1-4a76-afa5-bccb894006f7', false);
INSERT INTO public.client_scope_client VALUES ('cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', 'c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd', false);
INSERT INTO public.client_scope_client VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', 'd0935e0d-5613-4699-976e-dce6aaa735d5', true);
INSERT INTO public.client_scope_client VALUES ('2e3752f9-bdc5-43f8-a221-c4ac3ad005b1', 'd0935e0d-5613-4699-976e-dce6aaa735d5', true);
INSERT INTO public.client_scope_client VALUES ('d997ff0b-7e46-4cac-9945-b7f070c09e77', 'd0935e0d-5613-4699-976e-dce6aaa735d5', true);
INSERT INTO public.client_scope_client VALUES ('9186b3e7-e5e7-4f08-8505-570149b2e740', 'd0935e0d-5613-4699-976e-dce6aaa735d5', true);
INSERT INTO public.client_scope_client VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', 'd0935e0d-5613-4699-976e-dce6aaa735d5', true);
INSERT INTO public.client_scope_client VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', '602f1759-5b71-4507-8fe1-c394ec186ac0', true);
INSERT INTO public.client_scope_client VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', '53cb249b-316a-461b-81bc-43f02f3b643f', true);
INSERT INTO public.client_scope_client VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', '1a58966d-0df4-469b-b05f-a0a57c9e3588', true);
INSERT INTO public.client_scope_client VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', '4ad5b5d0-53e8-4681-827c-95d193f27949', true);
INSERT INTO public.client_scope_client VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', '5af6c506-33c5-4ece-9f32-b24e7b5fff0e', false);
INSERT INTO public.client_scope_client VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', '74927a2e-4aaf-4666-ba11-7356382bacad', false);
INSERT INTO public.client_scope_client VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', 'b2ca3287-fa66-4708-b3fa-1d98a47fbd88', false);
INSERT INTO public.client_scope_client VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', 'b923fc2d-1f91-47dc-9eb6-a3683edde275', false);
INSERT INTO public.client_scope_client VALUES ('2e3752f9-bdc5-43f8-a221-c4ac3ad005b1', '602f1759-5b71-4507-8fe1-c394ec186ac0', true);
INSERT INTO public.client_scope_client VALUES ('2e3752f9-bdc5-43f8-a221-c4ac3ad005b1', '53cb249b-316a-461b-81bc-43f02f3b643f', true);
INSERT INTO public.client_scope_client VALUES ('2e3752f9-bdc5-43f8-a221-c4ac3ad005b1', '1a58966d-0df4-469b-b05f-a0a57c9e3588', true);
INSERT INTO public.client_scope_client VALUES ('2e3752f9-bdc5-43f8-a221-c4ac3ad005b1', '4ad5b5d0-53e8-4681-827c-95d193f27949', true);
INSERT INTO public.client_scope_client VALUES ('2e3752f9-bdc5-43f8-a221-c4ac3ad005b1', '5af6c506-33c5-4ece-9f32-b24e7b5fff0e', false);
INSERT INTO public.client_scope_client VALUES ('2e3752f9-bdc5-43f8-a221-c4ac3ad005b1', '74927a2e-4aaf-4666-ba11-7356382bacad', false);
INSERT INTO public.client_scope_client VALUES ('2e3752f9-bdc5-43f8-a221-c4ac3ad005b1', 'b2ca3287-fa66-4708-b3fa-1d98a47fbd88', false);
INSERT INTO public.client_scope_client VALUES ('2e3752f9-bdc5-43f8-a221-c4ac3ad005b1', 'b923fc2d-1f91-47dc-9eb6-a3683edde275', false);
INSERT INTO public.client_scope_client VALUES ('d997ff0b-7e46-4cac-9945-b7f070c09e77', '602f1759-5b71-4507-8fe1-c394ec186ac0', true);
INSERT INTO public.client_scope_client VALUES ('d997ff0b-7e46-4cac-9945-b7f070c09e77', '53cb249b-316a-461b-81bc-43f02f3b643f', true);
INSERT INTO public.client_scope_client VALUES ('d997ff0b-7e46-4cac-9945-b7f070c09e77', '1a58966d-0df4-469b-b05f-a0a57c9e3588', true);
INSERT INTO public.client_scope_client VALUES ('d997ff0b-7e46-4cac-9945-b7f070c09e77', '4ad5b5d0-53e8-4681-827c-95d193f27949', true);
INSERT INTO public.client_scope_client VALUES ('d997ff0b-7e46-4cac-9945-b7f070c09e77', '5af6c506-33c5-4ece-9f32-b24e7b5fff0e', false);
INSERT INTO public.client_scope_client VALUES ('d997ff0b-7e46-4cac-9945-b7f070c09e77', '74927a2e-4aaf-4666-ba11-7356382bacad', false);
INSERT INTO public.client_scope_client VALUES ('d997ff0b-7e46-4cac-9945-b7f070c09e77', 'b2ca3287-fa66-4708-b3fa-1d98a47fbd88', false);
INSERT INTO public.client_scope_client VALUES ('d997ff0b-7e46-4cac-9945-b7f070c09e77', 'b923fc2d-1f91-47dc-9eb6-a3683edde275', false);
INSERT INTO public.client_scope_client VALUES ('9186b3e7-e5e7-4f08-8505-570149b2e740', '602f1759-5b71-4507-8fe1-c394ec186ac0', true);
INSERT INTO public.client_scope_client VALUES ('9186b3e7-e5e7-4f08-8505-570149b2e740', '53cb249b-316a-461b-81bc-43f02f3b643f', true);
INSERT INTO public.client_scope_client VALUES ('9186b3e7-e5e7-4f08-8505-570149b2e740', '1a58966d-0df4-469b-b05f-a0a57c9e3588', true);
INSERT INTO public.client_scope_client VALUES ('9186b3e7-e5e7-4f08-8505-570149b2e740', '4ad5b5d0-53e8-4681-827c-95d193f27949', true);
INSERT INTO public.client_scope_client VALUES ('9186b3e7-e5e7-4f08-8505-570149b2e740', '5af6c506-33c5-4ece-9f32-b24e7b5fff0e', false);
INSERT INTO public.client_scope_client VALUES ('9186b3e7-e5e7-4f08-8505-570149b2e740', '74927a2e-4aaf-4666-ba11-7356382bacad', false);
INSERT INTO public.client_scope_client VALUES ('9186b3e7-e5e7-4f08-8505-570149b2e740', 'b2ca3287-fa66-4708-b3fa-1d98a47fbd88', false);
INSERT INTO public.client_scope_client VALUES ('9186b3e7-e5e7-4f08-8505-570149b2e740', 'b923fc2d-1f91-47dc-9eb6-a3683edde275', false);
INSERT INTO public.client_scope_client VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', '602f1759-5b71-4507-8fe1-c394ec186ac0', true);
INSERT INTO public.client_scope_client VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', '53cb249b-316a-461b-81bc-43f02f3b643f', true);
INSERT INTO public.client_scope_client VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', '1a58966d-0df4-469b-b05f-a0a57c9e3588', true);
INSERT INTO public.client_scope_client VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', '4ad5b5d0-53e8-4681-827c-95d193f27949', true);
INSERT INTO public.client_scope_client VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', '5af6c506-33c5-4ece-9f32-b24e7b5fff0e', false);
INSERT INTO public.client_scope_client VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', '74927a2e-4aaf-4666-ba11-7356382bacad', false);
INSERT INTO public.client_scope_client VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', 'b2ca3287-fa66-4708-b3fa-1d98a47fbd88', false);
INSERT INTO public.client_scope_client VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', 'b923fc2d-1f91-47dc-9eb6-a3683edde275', false);
INSERT INTO public.client_scope_client VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'd0935e0d-5613-4699-976e-dce6aaa735d5', true);
INSERT INTO public.client_scope_client VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', '602f1759-5b71-4507-8fe1-c394ec186ac0', true);
INSERT INTO public.client_scope_client VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', '53cb249b-316a-461b-81bc-43f02f3b643f', true);
INSERT INTO public.client_scope_client VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', '1a58966d-0df4-469b-b05f-a0a57c9e3588', true);
INSERT INTO public.client_scope_client VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', '4ad5b5d0-53e8-4681-827c-95d193f27949', true);
INSERT INTO public.client_scope_client VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', '5af6c506-33c5-4ece-9f32-b24e7b5fff0e', false);
INSERT INTO public.client_scope_client VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', '74927a2e-4aaf-4666-ba11-7356382bacad', false);
INSERT INTO public.client_scope_client VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'b2ca3287-fa66-4708-b3fa-1d98a47fbd88', false);
INSERT INTO public.client_scope_client VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'b923fc2d-1f91-47dc-9eb6-a3683edde275', false);


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.client_scope_role_mapping VALUES ('910c03d1-2a03-42e6-9acf-0314ea147127', 'd4b04fdd-204c-4624-ad90-7930b326e61f');
INSERT INTO public.client_scope_role_mapping VALUES ('5af6c506-33c5-4ece-9f32-b24e7b5fff0e', '8057a484-a6f7-45af-b028-8700dfcfe7b7');


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.component VALUES ('95947608-790f-4af4-b531-397ba61fce78', 'Trusted Hosts', 'master', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('31667a2a-1491-400c-9f47-0a1df89053d8', 'Consent Required', 'master', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('32c30036-9154-4566-94b9-b22fc4e33517', 'Full Scope Disabled', 'master', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('927dd239-710b-4c29-a6fd-6dfe0c83076c', 'Max Clients Limit', 'master', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('f9477308-ac0f-4b68-b996-8ae5d8c2b86f', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('23f731ce-78ea-4169-89fc-e1cfd9062873', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component VALUES ('9733fea8-e977-4729-a640-d2463fbaacfb', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO public.component VALUES ('a4bf109c-65dd-4b3b-96a5-59673c4df661', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO public.component VALUES ('38c6fecd-5e44-4899-a175-ff83b381eea9', 'rsa-generated', 'master', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component VALUES ('2209d87e-bd27-49ac-81a2-a8a101edeac5', 'hmac-generated', 'master', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component VALUES ('9f6b9920-8972-496f-a728-a6e7536b0721', 'aes-generated', 'master', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component VALUES ('6baa8866-0436-4a71-8276-c4c4167de504', 'rsa-generated', 'my_realm', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'my_realm', NULL);
INSERT INTO public.component VALUES ('525a67dd-49d2-4b81-9450-4ce8426a809e', 'hmac-generated', 'my_realm', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'my_realm', NULL);
INSERT INTO public.component VALUES ('09280765-b5b5-41c5-9fb0-493658f3f7c0', 'aes-generated', 'my_realm', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'my_realm', NULL);
INSERT INTO public.component VALUES ('940ab368-4d9f-433d-9d17-9f8d8b92f467', 'Trusted Hosts', 'my_realm', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'my_realm', 'anonymous');
INSERT INTO public.component VALUES ('951e22fd-f223-42e1-9f06-e96b87e680e9', 'Consent Required', 'my_realm', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'my_realm', 'anonymous');
INSERT INTO public.component VALUES ('3fe9c2dc-f81b-4f24-992e-4d2b18f632e7', 'Full Scope Disabled', 'my_realm', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'my_realm', 'anonymous');
INSERT INTO public.component VALUES ('953ee5fc-94e8-4abc-8db7-9e4429ece221', 'Max Clients Limit', 'my_realm', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'my_realm', 'anonymous');
INSERT INTO public.component VALUES ('53df9a8d-57f2-43c9-88f3-d645d67b592e', 'Allowed Protocol Mapper Types', 'my_realm', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'my_realm', 'anonymous');
INSERT INTO public.component VALUES ('43d2a077-b8e5-4348-be7c-7f46bbf249c5', 'Allowed Client Scopes', 'my_realm', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'my_realm', 'anonymous');
INSERT INTO public.component VALUES ('c747951c-b9e7-48b2-ba07-97689673044b', 'Allowed Protocol Mapper Types', 'my_realm', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'my_realm', 'authenticated');
INSERT INTO public.component VALUES ('e248ea01-4120-4dd8-8766-a99c6c7969a9', 'Allowed Client Scopes', 'my_realm', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'my_realm', 'authenticated');


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.component_config VALUES ('9172b201-53e2-4a8f-8f22-7a5d9a712d50', '927dd239-710b-4c29-a6fd-6dfe0c83076c', 'max-clients', '200');
INSERT INTO public.component_config VALUES ('4070f434-2dd3-41af-95f0-29fa9dddf2ed', '95947608-790f-4af4-b531-397ba61fce78', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config VALUES ('ae1e1a42-d82e-44d8-8771-871ceb6bfa10', '95947608-790f-4af4-b531-397ba61fce78', 'client-uris-must-match', 'true');
INSERT INTO public.component_config VALUES ('8839581c-a3d5-4fc0-abf3-df1276c9e576', '9733fea8-e977-4729-a640-d2463fbaacfb', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('72570040-c0df-4f64-a1f1-b99f2f9b9952', '9733fea8-e977-4729-a640-d2463fbaacfb', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('5d86ff13-6ecc-4385-a23b-cc8d285ca202', '9733fea8-e977-4729-a640-d2463fbaacfb', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('948e012f-fabf-466a-bd89-75d926db0ac4', '9733fea8-e977-4729-a640-d2463fbaacfb', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('7ee56ab7-f15b-4f1a-9fb6-f86625d99feb', '9733fea8-e977-4729-a640-d2463fbaacfb', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('0aaed209-5153-44b4-be65-eca01ddbd59c', '9733fea8-e977-4729-a640-d2463fbaacfb', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('53bd8183-28da-4545-b45f-e3274fb1da55', '9733fea8-e977-4729-a640-d2463fbaacfb', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('8972526c-71aa-4055-ad58-bd5d70203045', '9733fea8-e977-4729-a640-d2463fbaacfb', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('733e4886-ef23-4167-87d7-468600525071', 'f9477308-ac0f-4b68-b996-8ae5d8c2b86f', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('3f1dc80b-1792-428a-9296-7d3d6fa340ec', 'f9477308-ac0f-4b68-b996-8ae5d8c2b86f', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('4a43abdf-d8ca-4f9b-82a9-b7db1c0fcc0b', 'f9477308-ac0f-4b68-b996-8ae5d8c2b86f', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('f1e36b88-25c1-4484-af2a-b3baaf24e7ce', 'f9477308-ac0f-4b68-b996-8ae5d8c2b86f', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('6486faf7-fbfe-4f5a-b866-39638af49e31', 'f9477308-ac0f-4b68-b996-8ae5d8c2b86f', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('3b850631-1a0b-4d51-b6ee-213ea2bc70b0', 'f9477308-ac0f-4b68-b996-8ae5d8c2b86f', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('5bc641c8-73ae-402e-9c6e-82b5fd55b674', 'f9477308-ac0f-4b68-b996-8ae5d8c2b86f', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('6e949bd0-b7d6-435e-ad40-3bebf79cd87a', 'f9477308-ac0f-4b68-b996-8ae5d8c2b86f', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('e41eaa1a-9c95-4d3c-8e58-112b6d991296', 'a4bf109c-65dd-4b3b-96a5-59673c4df661', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('2fd0d6ea-f1e7-44f6-b172-b4e034465e51', '23f731ce-78ea-4169-89fc-e1cfd9062873', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('f0f5781c-e35b-4916-8192-d65294f33b9e', '9f6b9920-8972-496f-a728-a6e7536b0721', 'priority', '100');
INSERT INTO public.component_config VALUES ('d7d773a4-a574-4e83-b89b-efb7b58cee40', '9f6b9920-8972-496f-a728-a6e7536b0721', 'kid', '3e3899bf-8085-4d8a-a194-880b725acf42');
INSERT INTO public.component_config VALUES ('53606c96-84f5-4024-bc8b-42cd9430ca6e', '9f6b9920-8972-496f-a728-a6e7536b0721', 'secret', 'tHYrk-Umb4g5FW3tE2ba9Q');
INSERT INTO public.component_config VALUES ('4c652406-8173-4894-a3d2-05a4249cbbc8', '2209d87e-bd27-49ac-81a2-a8a101edeac5', 'algorithm', 'HS256');
INSERT INTO public.component_config VALUES ('97f997f8-dcb8-4425-8baa-4371a2be410a', '2209d87e-bd27-49ac-81a2-a8a101edeac5', 'kid', '1a6927f9-9de8-4b8e-915c-517686760395');
INSERT INTO public.component_config VALUES ('ddf3034d-d070-4fa8-bae2-ae9585d7f768', '2209d87e-bd27-49ac-81a2-a8a101edeac5', 'secret', 'Xut7hHHFOsG3RanqoSazZk0iwjfflkU9lhK9WPS9xnpYQ5EbZfzhNLyzNKfTMYVkazkYCangEy5teAUwqdVr1w');
INSERT INTO public.component_config VALUES ('3d0d43aa-9d77-4de9-bc63-d85abae4c0bd', '2209d87e-bd27-49ac-81a2-a8a101edeac5', 'priority', '100');
INSERT INTO public.component_config VALUES ('a6de0d03-a85e-4881-adc1-ee68ac9c8ea8', '38c6fecd-5e44-4899-a175-ff83b381eea9', 'priority', '100');
INSERT INTO public.component_config VALUES ('828fcf45-175d-4f2a-a87a-b796ea6b3a5c', '38c6fecd-5e44-4899-a175-ff83b381eea9', 'certificate', 'MIICmzCCAYMCBgFvoysXLDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjAwMTE0MDgyNjQ3WhcNMzAwMTE0MDgyODI3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCX19Sw228IlAXtyK6FyBBFmXn/3CxZ86zEUpZrY7f8baznntp8FuFTc+gd6I3y9dVFPUdYtyPJFzgHLDUf2sUdfrII6IeATD67fQoLBE3oYJC2C/ome24XXhwr+JdguKVLeYdbi5EkLlIw1bV6iOZMYgSrOSCIUmxl5MiU2zCBKefhbii/JYovEhVF2iTyIWxJ3pmlMs8+CvoLQ3bwGXL50ynnXWW9fWtTyQQe+B5nP4E4jki11byPqCdfpwqAVXpyy+S6Jd6uNrZYc0/QhSO1O9S/VsjPEc4bskiIs4AuA50VjMMu+75pNxPAx8k6s0hrz4o3zDtAdzfxKRbJ97HfAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAELNjNVqUM+Nvg1x/Jm31EIMdwdBMNmfUEi7zUmuuZPlLcp/a+Dsxltvom5n3PId4nNm3bx5HVo8X9wDgkO4OpWr1I8El7Cbog68CnsVs5yfh4l9nZPBXFi5j/uEWeh+VMmsBltI5MYCPPd1tfQIKahYs5yd6RSN2b+7cmsmKrb63HlapGFSYXvwXlTtP1SyXiBiFvd1EKPdhlktDkO0/SKTN/BAv/fvg7OyXO8hwZK8NNzh7f2eK6XsPb1V6ONUEno/RctgMqXMEs1ROB54oDJ1u0/MsFL1sagUGG2jvI9JV4zhq8leRg9Tk60Kro5z6IlZiSA1Tjm74nRlULTSRmw=');
INSERT INTO public.component_config VALUES ('e8d45a47-9484-4231-b227-b30eb2c45aa3', '38c6fecd-5e44-4899-a175-ff83b381eea9', 'privateKey', 'MIIEowIBAAKCAQEAl9fUsNtvCJQF7ciuhcgQRZl5/9wsWfOsxFKWa2O3/G2s557afBbhU3PoHeiN8vXVRT1HWLcjyRc4Byw1H9rFHX6yCOiHgEw+u30KCwRN6GCQtgv6JntuF14cK/iXYLilS3mHW4uRJC5SMNW1eojmTGIEqzkgiFJsZeTIlNswgSnn4W4ovyWKLxIVRdok8iFsSd6ZpTLPPgr6C0N28Bly+dMp511lvX1rU8kEHvgeZz+BOI5ItdW8j6gnX6cKgFV6csvkuiXerja2WHNP0IUjtTvUv1bIzxHOG7JIiLOALgOdFYzDLvu+aTcTwMfJOrNIa8+KN8w7QHc38SkWyfex3wIDAQABAoIBAFxfa7+vrot8aWLvq+QtAmEk7ggOLFkImXjReTqZbms9WWuKwwWscaVwJKxVNk2w6e52SfoZZ8bEvkv2w9a+Ix4/XhV3SD9votYySjLLio2seTyWaraQbjf/A4pob8bibYRNyV+St1hYaZ3V1NJXiCq9knOLjFQCOHmARdnwwkBAhe4YeA47BAVh2/9HL1fMwdjv/8bKW13KwKSmEwknnznFkJVdAsDAMiMmFIw/+ZvgF+6+dPtORpx44OjyhhhNzO04C2fFC6CQGRkanU3TkgnvlMSJCTNNpnG2hpkMTJig+ITRMtN1L3xBYrif5Xo/t4W6Oq+n1BZLuUwHIefOU6kCgYEA8wiHpYee9JaOh0OGRZUMbSCTRmtHSXyzfdCspTTaLWPEJmTm64fW9dPoW12yG1TUg0wDupChSFs94Ad6DnDLZTR1cjBWBM/VnC/DqbTlpy/yNazoATsldSiSJI6ulzcXhiPhuVpsdlW5+JBFdnx9tdpMgSCB2Di5Ww4Gzwf/hVMCgYEAn/HHhG0NC6Z2DIJHPqoj4GMkbANFEA6MJC5fKe+F4ADCG1UEchG5kzoHOdEVyn2lBRwzuBHbT7JG6maygnd/G6ODlvQDSZCin+HJdxcdwb4Vgpz+TdvOv4X330zQBbSdc0lD/vsheC+iBVayiBnPd4A8Bc+Br7c+D7EoAh89Y8UCgYEAsaMEcssENkZtexSx6d4drQ3oV8pF2sLY9xc1ebN93TtUvbN2zaUGS7xN06pSaoPAqQ9AknbwS9DVExCj+DYdlKWZSpNl7DJ1Man/2+UrDt6OrQjqsyumH1I+L5ZSqphMC3HipPYg3QWf3ryk6QvpXqhmzuMRxRcA9Dr2YxC3hZ0CgYAMUns1h5U+tYdYtVy5xi/XZKv0qlfSwdwoGW55c5uTw1sw8d7SzuzGG+1clfAg1oc1GpQddTq5LBnsixbrmDsxrOpBYfEy5LKysJlt1FkViQhtNJ0e8HVAKhkLmgZYui57KETVyxEsCjdoQ+KjO6HRKg71v6PVHr/oQ5S6fR+kpQKBgAVwlwtovBg3Ldbq2gkViMyg1sulPz9LcP39iiRmbH80mF4zRUkvqeIREoYYMOAMrgG8rGJe+8sTBBJezfFJr9Svd0UOpu+ahHzNuknGrFejh0mziJojmeIOzZ4ZSDJdygQwJWs6pYWPzrGyzR1PmajIsyar7Sc7Wue66Z+oBPew');
INSERT INTO public.component_config VALUES ('aea53120-0eae-4ec7-be2f-a83425d01f81', '525a67dd-49d2-4b81-9450-4ce8426a809e', 'algorithm', 'HS256');
INSERT INTO public.component_config VALUES ('11aadc15-1785-4ab4-9990-150097fc865a', '525a67dd-49d2-4b81-9450-4ce8426a809e', 'kid', 'c25d25ea-8f44-4ef5-8a14-fc1071492ba6');
INSERT INTO public.component_config VALUES ('c672bc28-22db-495d-8ad2-afdde5997e47', '525a67dd-49d2-4b81-9450-4ce8426a809e', 'secret', 'OWGgESa90vSbsZDfnldVolyRJTPhj9emre8XnGw1d0OVqAQ6k-n1gF8_IF73iyLCxHQm5OHV65czaM-2gk_WuQ');
INSERT INTO public.component_config VALUES ('8849d804-a364-4d79-972c-703474dd137c', '525a67dd-49d2-4b81-9450-4ce8426a809e', 'priority', '100');
INSERT INTO public.component_config VALUES ('2468cb5d-5822-4543-aa8f-e107434e09ca', '09280765-b5b5-41c5-9fb0-493658f3f7c0', 'priority', '100');
INSERT INTO public.component_config VALUES ('ad01c435-a2d2-4d19-9d5d-29de92243570', '09280765-b5b5-41c5-9fb0-493658f3f7c0', 'kid', 'b4f173c1-67ed-41f3-98f3-8382b4aa60a4');
INSERT INTO public.component_config VALUES ('f93512be-0171-4cb4-9238-f3ca0b9df6ce', '09280765-b5b5-41c5-9fb0-493658f3f7c0', 'secret', 'nNAiQm6Eji_SO7eDtqoY8A');
INSERT INTO public.component_config VALUES ('eeb09df2-5143-49ac-9540-7ea1e40cad23', '6baa8866-0436-4a71-8276-c4c4167de504', 'priority', '100');
INSERT INTO public.component_config VALUES ('63f37e69-9e35-4308-be2e-7144ffafc3ad', '6baa8866-0436-4a71-8276-c4c4167de504', 'certificate', 'MIICnzCCAYcCBgFvoyvfujANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhteV9yZWFsbTAeFw0yMDAxMTQwODI3MzlaFw0zMDAxMTQwODI5MTlaMBMxETAPBgNVBAMMCG15X3JlYWxtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzTuoyrmT/MwcCWYaEAqgOlF6QSQHzg7xrCy8BktJGRW3irI0zQYKvkvhnXcJH1lINAcDykA93gpW83nnGU/CxMtt0q4GzWxCpspDsW9yLpenarEv9NoxIFxYJBJqM7oB4ecQbqXM5Facs9noiOJqBlqwp9zmMzrWbEmbGQyb0c1T5xB8Skoyx1NN0PdcOb2zq6Fbumz+ifxZmz0Geie6X8Q8XwlOUwlWho8Ay9Vs5n00AKWT/lblIqG+ogRVcLrXYwcWNWPaPrf5d9N0sBRPI3NYkWDVFS0rj+BeHOAJQqX/nAgx+9ukxd5s6qDKZBdp4pDeEsGgi+zBW5Rt6o5yzwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAu7iZT4L7cb9WkFOUfg2wO18tRVFuL4sgouMcaEB9nSQCy2QqBOxA6xocPfnVqO52EaeSOjDoMWMurYgX0R/uqb7oBynSS1To2NPBxdC91+01d7Ub3n3jjQUhA1JlUrvEiVwNSu8J4aCGjaJ0mVTJrJOzurvMgWK4FrlSNSR2xKgX51DUGJ0Bt53lyVekmNoq8UcFF1ufZl0GITQAO3g2OqHmEG4aSnmoJFbye8RiHtMa/Y7h0iVwgWk2jGf1kROB2vtRDFZsVZTYSTHyQRR2vxjaXaAH3FxR5rYoVcS3dvKLo+xz0q/oUf9SPEJS/udRigN7S9cWt28uJ9BaC5xB2');
INSERT INTO public.component_config VALUES ('7777c3bb-353e-4442-b1f0-cee5d47e875c', '6baa8866-0436-4a71-8276-c4c4167de504', 'privateKey', 'MIIEpgIBAAKCAQEAzTuoyrmT/MwcCWYaEAqgOlF6QSQHzg7xrCy8BktJGRW3irI0zQYKvkvhnXcJH1lINAcDykA93gpW83nnGU/CxMtt0q4GzWxCpspDsW9yLpenarEv9NoxIFxYJBJqM7oB4ecQbqXM5Facs9noiOJqBlqwp9zmMzrWbEmbGQyb0c1T5xB8Skoyx1NN0PdcOb2zq6Fbumz+ifxZmz0Geie6X8Q8XwlOUwlWho8Ay9Vs5n00AKWT/lblIqG+ogRVcLrXYwcWNWPaPrf5d9N0sBRPI3NYkWDVFS0rj+BeHOAJQqX/nAgx+9ukxd5s6qDKZBdp4pDeEsGgi+zBW5Rt6o5yzwIDAQABAoIBAQCcIVPCjbWAbsKxf8Q6CetlElEAN2ncn8/I3OtZmnKMq9HKqNG0W3FW3aFQyprdB23/boq6lW67eYA2j7l4rw4L6nqs+Qlhw4ddHair1o211lddulgyXL9c0AOZxYyXt1zxP3hnxKh/2UgzJoZZhG2GUf3sZgeWV5+CF+jvAIGV89IVLmQl3A38oKqzjyqGL5qzldyWKRPfNdJeMFSdUq7Nj4PKXB0G3twOi2P312GHGOxD78cZQ+sV/KWY32qY5quo9B3fruus8lD1oK/dmtzqfyMWrOaNxi36TwFlCYeQRtDsMTR22garaEyZe/BXAyuSjI+g0KjerWQ0lGSnTeVxAoGBAPLy/QWdlswLJGhKgxXK5VBczeXzlLERsWaaz5sQ2LNFgIAwUMLodfhzshF6bz+ZwpicV6Rgt2eNuThffF/ECQGRLbzi1LTIIUICjmKHNaQFIibIocRRVmIzPiEk1/ps/jXWn0v+m9ODmiWnCaVeOX+MEtPx0EWxJoBczGp6WRupAoGBANhCALHR3AXImcNaS+0k5marj4hNdSLi78ZYYtkoIfMfTiLbN0rVEyJcQDN5fnzf5vAhV8DamjnHVRBFvX3Rsu+yAT29cE46alfZvKPLEM0CuRzDg6AM0IS1Zvrztq4s1dXCtVCF/mN6IIp6aSI0SCOE53GHb0zR2/llt+jsomW3AoGBALbUA3NBZ6T/0ZMmV8WDndQ/MreU+dXS8cS8RfV01Q78A7r0ISK8W2LwdhXPJH8hUB8WsKHEIuEr9zIkMW3EEd77CQd3UAkH/nc1gz9EbyqSrmOvYoVhjHd0BpJcrqgHc7rCW7iNz2h6RfuF26113iFNITIcbNa1fLrmmvKaRgqZAoGBAM0v4sTVX7PFH8+xDzVUu59SzH8BL1EIjYRePHvajkvFujdsU8wW227QpMGyVwdY0h+pI0ACqi6EKPulkCOfIe43sOHJqpMu7dOo7kli1PAP01+tSmhDgF1KWQlm0D/2nnWRpsNeP35XVCTP/IzNmlzJL2gSntH+lH7Pum2wiG2FAoGBAJr7EcaCZq1CAFCBEzSCuSijEFEnijHfAiN/xKmzKQVOdlz87LRiJQrLc74bQXu6/yKM8xOHdxlM3JZi4H5Amjp86F/Ynn77m70pcwPWyQsRmPFmXIJ0eAxFyNtIYJKV45n5fuLU3ibBQtjgeU57W1fBilrtJ/f4YtKuh92DHfkY');
INSERT INTO public.component_config VALUES ('b4a6e2b8-4c21-4039-b926-72af7ef65428', 'e248ea01-4120-4dd8-8766-a99c6c7969a9', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('dbce50c2-d7cb-45d8-a8b0-c8c97e0a641a', '53df9a8d-57f2-43c9-88f3-d645d67b592e', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('9a12ce2f-c9d1-4707-82ba-b7640bc8289d', '53df9a8d-57f2-43c9-88f3-d645d67b592e', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('a36fabb4-03b7-49f0-b04a-7b7f3f7d8073', '53df9a8d-57f2-43c9-88f3-d645d67b592e', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('5b4338b8-eca8-4270-8c8a-86612dfa4696', '53df9a8d-57f2-43c9-88f3-d645d67b592e', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('c84d0dc6-ff02-4fb2-906b-d2b2e8e75a5f', '53df9a8d-57f2-43c9-88f3-d645d67b592e', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('9b3f9c43-1ad9-4b85-9a68-f54f294b8e0f', '53df9a8d-57f2-43c9-88f3-d645d67b592e', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('c7c9c6fa-1237-487d-8d25-8fafa321ecff', '53df9a8d-57f2-43c9-88f3-d645d67b592e', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('3f7fa40c-00af-49f7-b5db-edf671d77e9a', '53df9a8d-57f2-43c9-88f3-d645d67b592e', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('ea9b2255-28d6-407a-9a2c-e53e8e8f96e9', '940ab368-4d9f-433d-9d17-9f8d8b92f467', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config VALUES ('360b1754-0e59-47c9-8920-715ebb13289a', '940ab368-4d9f-433d-9d17-9f8d8b92f467', 'client-uris-must-match', 'true');
INSERT INTO public.component_config VALUES ('d61f159c-58b8-4be5-be82-aa16d9541571', '43d2a077-b8e5-4348-be7c-7f46bbf249c5', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('e1b0c56c-9566-42f6-a18f-a4febb08e4d9', 'c747951c-b9e7-48b2-ba07-97689673044b', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('58505f6e-d506-40b2-8199-e1cc80410c21', 'c747951c-b9e7-48b2-ba07-97689673044b', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('0234100c-bec8-42a6-86ae-eb694ac46625', 'c747951c-b9e7-48b2-ba07-97689673044b', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('2b6a13c0-0ce1-44b1-8a53-a9d1d1644dec', 'c747951c-b9e7-48b2-ba07-97689673044b', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('7e42f78a-f6b2-43b9-a067-733905d0683a', 'c747951c-b9e7-48b2-ba07-97689673044b', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('794f1b16-f93c-47f4-851a-0f173a354d07', 'c747951c-b9e7-48b2-ba07-97689673044b', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('bcfc68d7-3beb-4b0c-b4b6-67b536d714a9', 'c747951c-b9e7-48b2-ba07-97689673044b', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('d484492a-78ef-40c1-a0c1-d0625d47da83', 'c747951c-b9e7-48b2-ba07-97689673044b', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('98426daf-6762-4ae2-abbe-261ca8577d41', '953ee5fc-94e8-4abc-8db7-9e4429ece221', 'max-clients', '200');


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '41a7f115-610c-4ea2-b519-cb030df99127');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '80715b45-2072-46c1-b253-69887440112b');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'dacedbb6-036a-4a79-9ad1-2984dab2429d');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'dc0815d0-0718-4e77-ab9a-19b46075b953');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '36644ae0-0272-4592-8989-f1e15b71735c');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '5be4720e-c071-453b-8a83-4b08a54ea746');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '60a831bc-febf-4f08-81f1-4eb35953ea48');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'fd3a8977-b763-4bbd-9d0f-9c8a83ca87b3');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '7ae6febc-3a51-4ef1-83f8-8ad2d84e7c7d');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '62ce788e-cfd7-4a9c-a12a-3d0fa9cfda9d');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '034faf4d-a5a5-42be-a0b3-6aebad42de62');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '86d6dd74-98c3-4657-8536-59f61fafcdc0');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '86d4206a-f7bd-4461-a7a0-5c7a027c1865');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '3a0ace98-1832-4e8e-99c3-54d1c5d84642');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '34536261-dc8d-43b3-b881-12517d86cdab');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '63ee69df-975e-467c-9e87-aca9217b6347');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '743d829a-27f7-4fc5-9775-330106bced10');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'f2bfbb32-e5e2-450d-8a5c-3674ea374279');
INSERT INTO public.composite_role VALUES ('dc0815d0-0718-4e77-ab9a-19b46075b953', 'f2bfbb32-e5e2-450d-8a5c-3674ea374279');
INSERT INTO public.composite_role VALUES ('dc0815d0-0718-4e77-ab9a-19b46075b953', '34536261-dc8d-43b3-b881-12517d86cdab');
INSERT INTO public.composite_role VALUES ('36644ae0-0272-4592-8989-f1e15b71735c', '63ee69df-975e-467c-9e87-aca9217b6347');
INSERT INTO public.composite_role VALUES ('403e3cc6-7fe6-4e7d-b48e-8f585781adc6', 'ed68f12f-58e3-4d87-9a9d-f35246ca35b1');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '96ae1f0f-7885-48a4-9cd7-48b265b359ef');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'e1293321-8c13-4e38-89ae-8362746acabc');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '66e8062b-3563-4bef-94e5-3a99ea80f14d');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '88bad5ee-f759-4297-8af9-30fa68343e56');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '9d96ab11-dfde-4021-af16-3c687f57f46f');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '93ac963d-c097-4ffc-a063-33a5803f9051');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'f6b37477-fc5e-41f8-9d06-2fe8b641c8ba');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'b01216aa-31f0-4f8b-93fa-4ff576e4cc62');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'b1f6de73-4011-4b4d-a252-cb8a67098dfb');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '718eabb3-c6bf-4a48-bf12-051f5332aeb8');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '471fcd8f-7147-45eb-8841-7c099971c567');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'de6242de-152b-42b8-b540-13cdd085b827');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '1d3a0972-e1eb-4d96-b04a-0379b9ed1b60');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '01bdeaa1-d018-4ce9-a3fa-3e135c83363f');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '9cfd51d7-d871-469b-bd7a-763a1927d463');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'd74e3acd-9f9a-4c50-95b2-250210043372');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '42e0ee66-c7c2-4f2e-9392-4c1df882e0a9');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '51e239b0-cbb5-4524-a839-5500fef62d12');
INSERT INTO public.composite_role VALUES ('88bad5ee-f759-4297-8af9-30fa68343e56', '51e239b0-cbb5-4524-a839-5500fef62d12');
INSERT INTO public.composite_role VALUES ('88bad5ee-f759-4297-8af9-30fa68343e56', '9cfd51d7-d871-469b-bd7a-763a1927d463');
INSERT INTO public.composite_role VALUES ('9d96ab11-dfde-4021-af16-3c687f57f46f', 'd74e3acd-9f9a-4c50-95b2-250210043372');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '7abadb2e-1e6e-451d-a615-8717db4349c8');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', 'eae3a136-55e9-4097-a76c-9c0d5c6575a5');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '9c558947-41af-40e2-973c-5368f590d37b');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '9ad72f04-f84c-45f9-807f-5a18796032b0');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', 'd80242b2-dd70-4a9b-8199-c1f6f4cba670');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '5da9b4c1-a0f6-4bb6-a023-6ae528ae5833');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '6a174db8-6fc1-462b-a642-6d0570b18f7d');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '6ef758e3-01ba-4b4d-9f59-7b2a475375e8');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', 'f4135766-c531-4805-879e-4ba22aeb8e9c');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', 'f88b7263-9d16-43c5-9149-f6d9626df1da');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '2d1acbc9-729f-4329-9571-c82a95937cb9');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', 'db3c191c-d79f-451c-ae5e-27d9134efcf4');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', 'a640bd3a-cb7c-42a8-84b6-6c8ac04693ea');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '701a704d-e3ee-423f-a711-c0990dac9f08');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', 'b55fcc40-160c-4467-8510-f2c586d1a854');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '8d526714-84ec-42ab-8f20-453e71385aa9');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '04eec52b-5d9f-427a-a31d-f26b5c882221');
INSERT INTO public.composite_role VALUES ('9c558947-41af-40e2-973c-5368f590d37b', '701a704d-e3ee-423f-a711-c0990dac9f08');
INSERT INTO public.composite_role VALUES ('9c558947-41af-40e2-973c-5368f590d37b', '04eec52b-5d9f-427a-a31d-f26b5c882221');
INSERT INTO public.composite_role VALUES ('9ad72f04-f84c-45f9-807f-5a18796032b0', 'b55fcc40-160c-4467-8510-f2c586d1a854');
INSERT INTO public.composite_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', '64f70066-84e7-477c-89c5-55aa07cd4d12');
INSERT INTO public.composite_role VALUES ('46a226ad-497e-44a9-8ed6-ee91c7b87c4e', 'd5bfd355-0365-4f62-8557-8bd1f6d0edfc');
INSERT INTO public.composite_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '23419795-e85f-48d5-b018-31194e2c8b00');


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.credential VALUES ('589800b9-7423-4f0b-99e3-7ec361a00ade', NULL, 'password', 'dc59f130-565e-41d0-8f43-94e028566fe0', 1578990508194, NULL, '{"value":"LPfzS4MX+76w97kOLggi0ro0WOXYaqQxhYhX1l/Auk41tjl+iB2Vll4FIbBd7hrrD0/fBUeKuFnWCwJ8HK/XrA==","salt":"Uv9wTbZ4ymJOsMgiHFoDAg=="}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}', 10);
INSERT INTO public.credential VALUES ('4351ceb4-dbd6-4139-8e80-83d920ca4aca', NULL, 'password', 'ba1ec4ba-47db-432f-879b-616fa2158b42', 1578990615465, NULL, '{"value":"o1mukJxPF+4FMYQ7mN+93D7n3ubrtdZjRfviWFh75rr/2w/rJVboE4aXp9DQU28rMGA+qlfe60ryM2W3tAJeIg==","salt":"MWBeFErAXtHpmAYWIyGs3Q=="}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}', 10);


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2020-01-14 08:28:22.679785', 1, 'EXECUTED', '7:4e70412f24a3f382c82183742ec79317', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2020-01-14 08:28:22.693429', 2, 'MARK_RAN', '7:cb16724583e9675711801c6875114f28', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2020-01-14 08:28:22.752176', 3, 'EXECUTED', '7:0310eb8ba07cec616460794d42ade0fa', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2020-01-14 08:28:22.75974', 4, 'EXECUTED', '7:5d25857e708c3233ef4439df1f93f012', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2020-01-14 08:28:22.907484', 5, 'EXECUTED', '7:c7a54a1041d58eb3817a4a883b4d4e84', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2020-01-14 08:28:22.910622', 6, 'MARK_RAN', '7:2e01012df20974c1c2a605ef8afe25b7', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2020-01-14 08:28:23.03243', 7, 'EXECUTED', '7:0f08df48468428e0f30ee59a8ec01a41', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2020-01-14 08:28:23.035836', 8, 'MARK_RAN', '7:a77ea2ad226b345e7d689d366f185c8c', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2020-01-14 08:28:23.051545', 9, 'EXECUTED', '7:a3377a2059aefbf3b90ebb4c4cc8e2ab', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2020-01-14 08:28:23.210462', 10, 'EXECUTED', '7:04c1dbedc2aa3e9756d1a1668e003451', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2020-01-14 08:28:23.2984', 11, 'EXECUTED', '7:36ef39ed560ad07062d956db861042ba', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2020-01-14 08:28:23.301257', 12, 'MARK_RAN', '7:d909180b2530479a716d3f9c9eaea3d7', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2020-01-14 08:28:23.406195', 13, 'EXECUTED', '7:cf12b04b79bea5152f165eb41f3955f6', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2020-01-14 08:28:23.447627', 14, 'EXECUTED', '7:7e32c8f05c755e8675764e7d5f514509', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2020-01-14 08:28:23.449515', 15, 'MARK_RAN', '7:980ba23cc0ec39cab731ce903dd01291', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2020-01-14 08:28:23.451194', 16, 'MARK_RAN', '7:2fa220758991285312eb84f3b4ff5336', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2020-01-14 08:28:23.452748', 17, 'EXECUTED', '7:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2020-01-14 08:28:23.529954', 18, 'EXECUTED', '7:91ace540896df890cc00a0490ee52bbc', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2020-01-14 08:28:23.588384', 19, 'EXECUTED', '7:c31d1646dfa2618a9335c00e07f89f24', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2020-01-14 08:28:23.593775', 20, 'EXECUTED', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2020-01-14 08:28:24.079127', 45, 'EXECUTED', '7:6a48ce645a3525488a90fbf76adf3bb3', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2020-01-14 08:28:23.595768', 21, 'MARK_RAN', '7:f987971fe6b37d963bc95fee2b27f8df', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2020-01-14 08:28:23.59787', 22, 'MARK_RAN', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2020-01-14 08:28:23.615269', 23, 'EXECUTED', '7:ed2dc7f799d19ac452cbcda56c929e47', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2020-01-14 08:28:23.619676', 24, 'EXECUTED', '7:80b5db88a5dda36ece5f235be8757615', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2020-01-14 08:28:23.621665', 25, 'MARK_RAN', '7:1437310ed1305a9b93f8848f301726ce', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2020-01-14 08:28:23.652632', 26, 'EXECUTED', '7:b82ffb34850fa0836be16deefc6a87c4', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2020-01-14 08:28:23.721345', 27, 'EXECUTED', '7:9cc98082921330d8d9266decdd4bd658', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2020-01-14 08:28:23.724293', 28, 'EXECUTED', '7:03d64aeed9cb52b969bd30a7ac0db57e', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2020-01-14 08:28:23.779039', 29, 'EXECUTED', '7:f1f9fd8710399d725b780f463c6b21cd', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2020-01-14 08:28:23.789966', 30, 'EXECUTED', '7:53188c3eb1107546e6f765835705b6c1', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2020-01-14 08:28:23.802706', 31, 'EXECUTED', '7:d6e6f3bc57a0c5586737d1351725d4d4', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2020-01-14 08:28:23.805865', 32, 'EXECUTED', '7:454d604fbd755d9df3fd9c6329043aa5', 'customChange', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2020-01-14 08:28:23.810039', 33, 'EXECUTED', '7:57e98a3077e29caf562f7dbf80c72600', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2020-01-14 08:28:23.811734', 34, 'MARK_RAN', '7:e4c7e8f2256210aee71ddc42f538b57a', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2020-01-14 08:28:23.831009', 35, 'EXECUTED', '7:09a43c97e49bc626460480aa1379b522', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2020-01-14 08:28:23.854713', 36, 'EXECUTED', '7:26bfc7c74fefa9126f2ce702fb775553', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2020-01-14 08:28:23.861682', 37, 'EXECUTED', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2020-01-14 08:28:23.865651', 38, 'EXECUTED', '7:37fc1781855ac5388c494f1442b3f717', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2020-01-14 08:28:23.889397', 39, 'EXECUTED', '7:13a27db0dae6049541136adad7261d27', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2020-01-14 08:28:23.891074', 40, 'MARK_RAN', '7:550300617e3b59e8af3a6294df8248a3', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2020-01-14 08:28:23.892734', 41, 'MARK_RAN', '7:e3a9482b8931481dc2772a5c07c44f17', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2020-01-14 08:28:23.896414', 42, 'EXECUTED', '7:72b07d85a2677cb257edb02b408f332d', 'customChange', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2020-01-14 08:28:24.05983', 43, 'EXECUTED', '7:a72a7858967bd414835d19e04d880312', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2020-01-14 08:28:24.075451', 44, 'EXECUTED', '7:94edff7cf9ce179e7e85f0cd78a3cf2c', 'addColumn tableName=USER_ENTITY', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2020-01-14 08:28:24.082977', 46, 'EXECUTED', '7:e64b5dcea7db06077c6e57d3b9e5ca14', 'customChange', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2020-01-14 08:28:24.085515', 47, 'MARK_RAN', '7:fd8cf02498f8b1e72496a20afc75178c', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2020-01-14 08:28:24.121735', 48, 'EXECUTED', '7:542794f25aa2b1fbabb7e577d6646319', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2020-01-14 08:28:24.136698', 49, 'EXECUTED', '7:edad604c882df12f74941dac3cc6d650', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2020-01-14 08:28:24.17955', 50, 'EXECUTED', '7:0f88b78b7b46480eb92690cbf5e44900', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2020-01-14 08:28:24.218636', 51, 'EXECUTED', '7:d560e43982611d936457c327f872dd59', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2020-01-14 08:28:24.221813', 52, 'EXECUTED', '7:c155566c42b4d14ef07059ec3b3bbd8e', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2020-01-14 08:28:24.224893', 53, 'EXECUTED', '7:b40376581f12d70f3c89ba8ddf5b7dea', 'update tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2020-01-14 08:28:24.227234', 54, 'EXECUTED', '7:a1132cc395f7b95b3646146c2e38f168', 'update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2020-01-14 08:28:24.232575', 55, 'EXECUTED', '7:d8dc5d89c789105cfa7ca0e82cba60af', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2020-01-14 08:28:24.236751', 56, 'EXECUTED', '7:7822e0165097182e8f653c35517656a3', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2020-01-14 08:28:24.274203', 57, 'EXECUTED', '7:c6538c29b9c9a08f9e9ea2de5c2b6375', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2020-01-14 08:28:24.360644', 58, 'EXECUTED', '7:6d4893e36de22369cf73bcb051ded875', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2020-01-14 08:28:24.419386', 59, 'EXECUTED', '7:57960fc0b0f0dd0563ea6f8b2e4a1707', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2020-01-14 08:28:24.423653', 60, 'EXECUTED', '7:2b4b8bff39944c7097977cc18dbceb3b', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2020-01-14 08:28:24.430304', 61, 'EXECUTED', '7:2aa42a964c59cd5b8ca9822340ba33a8', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2020-01-14 08:28:24.435397', 62, 'EXECUTED', '7:9ac9e58545479929ba23f4a3087a0346', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2020-01-14 08:28:24.437992', 63, 'EXECUTED', '7:14d407c35bc4fe1976867756bcea0c36', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2020-01-14 08:28:24.439956', 64, 'EXECUTED', '7:241a8030c748c8548e346adee548fa93', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2020-01-14 08:28:24.442017', 65, 'EXECUTED', '7:7d3182f65a34fcc61e8d23def037dc3f', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2020-01-14 08:28:24.453311', 66, 'EXECUTED', '7:b30039e00a0b9715d430d1b0636728fa', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2020-01-14 08:28:24.459311', 67, 'EXECUTED', '7:3797315ca61d531780f8e6f82f258159', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2020-01-14 08:28:24.486053', 68, 'EXECUTED', '7:c7aa4c8d9573500c2d347c1941ff0301', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2020-01-14 08:28:24.502124', 69, 'EXECUTED', '7:b207faee394fc074a442ecd42185a5dd', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2020-01-14 08:28:24.507607', 70, 'EXECUTED', '7:ab9a9762faaba4ddfa35514b212c4922', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2020-01-14 08:28:24.514707', 71, 'EXECUTED', '7:b9710f74515a6ccb51b72dc0d19df8c4', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2020-01-14 08:28:24.518883', 72, 'EXECUTED', '7:ec9707ae4d4f0b7452fee20128083879', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2020-01-14 08:28:24.524114', 73, 'EXECUTED', '7:03b3f4b264c3c68ba082250a80b74216', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2020-01-14 08:28:24.5257', 74, 'MARK_RAN', '7:64c5728f5ca1f5aa4392217701c4fe23', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('8.0.0-credential-cleanup', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2020-01-14 08:28:24.536094', 75, 'EXECUTED', '7:41f3566ac5177459e1ed3ce8f0ad35d2', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '3.5.4', NULL, NULL, '8990502431');
INSERT INTO public.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2020-01-14 08:28:24.547252', 76, 'EXECUTED', '7:a73379915c23bfad3e8f5c6d5c0aa4bd', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '3.5.4', NULL, NULL, '8990502431');


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.databasechangeloglock VALUES (1, false, NULL, NULL);
INSERT INTO public.databasechangeloglock VALUES (1000, false, NULL, NULL);
INSERT INTO public.databasechangeloglock VALUES (1001, false, NULL, NULL);


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.default_client_scope VALUES ('master', '910c03d1-2a03-42e6-9acf-0314ea147127', false);
INSERT INTO public.default_client_scope VALUES ('master', '68572a70-8caa-4133-ab6d-6ee4cc4fc823', true);
INSERT INTO public.default_client_scope VALUES ('master', 'a62a2286-17be-4c14-9f0e-95b674e68d35', true);
INSERT INTO public.default_client_scope VALUES ('master', '44902f57-993d-4987-9e63-c98ff9fd0d2f', true);
INSERT INTO public.default_client_scope VALUES ('master', 'cefa2dca-d8a1-4d58-9715-b1fedb03cf2f', false);
INSERT INTO public.default_client_scope VALUES ('master', '6dfef3b0-6fe1-4a76-afa5-bccb894006f7', false);
INSERT INTO public.default_client_scope VALUES ('master', '68eabe34-176c-4075-a9aa-bf373f064ba0', true);
INSERT INTO public.default_client_scope VALUES ('master', 'a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95', true);
INSERT INTO public.default_client_scope VALUES ('master', 'c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd', false);
INSERT INTO public.default_client_scope VALUES ('my_realm', '5af6c506-33c5-4ece-9f32-b24e7b5fff0e', false);
INSERT INTO public.default_client_scope VALUES ('my_realm', 'd0935e0d-5613-4699-976e-dce6aaa735d5', true);
INSERT INTO public.default_client_scope VALUES ('my_realm', '602f1759-5b71-4507-8fe1-c394ec186ac0', true);
INSERT INTO public.default_client_scope VALUES ('my_realm', '53cb249b-316a-461b-81bc-43f02f3b643f', true);
INSERT INTO public.default_client_scope VALUES ('my_realm', '74927a2e-4aaf-4666-ba11-7356382bacad', false);
INSERT INTO public.default_client_scope VALUES ('my_realm', 'b2ca3287-fa66-4708-b3fa-1d98a47fbd88', false);
INSERT INTO public.default_client_scope VALUES ('my_realm', '1a58966d-0df4-469b-b05f-a0a57c9e3588', true);
INSERT INTO public.default_client_scope VALUES ('my_realm', '4ad5b5d0-53e8-4681-827c-95d193f27949', true);
INSERT INTO public.default_client_scope VALUES ('my_realm', 'b923fc2d-1f91-47dc-9eb6-a3683edde275', false);


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.keycloak_role VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'master', false, '${role_admin}', 'admin', 'master', NULL, 'master');
INSERT INTO public.keycloak_role VALUES ('41a7f115-610c-4ea2-b519-cb030df99127', 'master', false, '${role_create-realm}', 'create-realm', 'master', NULL, 'master');
INSERT INTO public.keycloak_role VALUES ('80715b45-2072-46c1-b253-69887440112b', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_create-client}', 'create-client', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('dacedbb6-036a-4a79-9ad1-2984dab2429d', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_view-realm}', 'view-realm', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('dc0815d0-0718-4e77-ab9a-19b46075b953', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_view-users}', 'view-users', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('36644ae0-0272-4592-8989-f1e15b71735c', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_view-clients}', 'view-clients', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('5be4720e-c071-453b-8a83-4b08a54ea746', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_view-events}', 'view-events', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('60a831bc-febf-4f08-81f1-4eb35953ea48', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('fd3a8977-b763-4bbd-9d0f-9c8a83ca87b3', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_view-authorization}', 'view-authorization', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('7ae6febc-3a51-4ef1-83f8-8ad2d84e7c7d', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_manage-realm}', 'manage-realm', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('62ce788e-cfd7-4a9c-a12a-3d0fa9cfda9d', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_manage-users}', 'manage-users', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('034faf4d-a5a5-42be-a0b3-6aebad42de62', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_manage-clients}', 'manage-clients', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('86d6dd74-98c3-4657-8536-59f61fafcdc0', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_manage-events}', 'manage-events', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('86d4206a-f7bd-4461-a7a0-5c7a027c1865', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('3a0ace98-1832-4e8e-99c3-54d1c5d84642', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_manage-authorization}', 'manage-authorization', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('34536261-dc8d-43b3-b881-12517d86cdab', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_query-users}', 'query-users', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('63ee69df-975e-467c-9e87-aca9217b6347', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_query-clients}', 'query-clients', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('743d829a-27f7-4fc5-9775-330106bced10', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_query-realms}', 'query-realms', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('f2bfbb32-e5e2-450d-8a5c-3674ea374279', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_query-groups}', 'query-groups', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('fc1cd5e9-44de-48f2-83cb-69fec15ec0d5', '3e938d5e-b26c-4e01-950d-cab2dce21b84', true, '${role_view-profile}', 'view-profile', 'master', '3e938d5e-b26c-4e01-950d-cab2dce21b84', NULL);
INSERT INTO public.keycloak_role VALUES ('403e3cc6-7fe6-4e7d-b48e-8f585781adc6', '3e938d5e-b26c-4e01-950d-cab2dce21b84', true, '${role_manage-account}', 'manage-account', 'master', '3e938d5e-b26c-4e01-950d-cab2dce21b84', NULL);
INSERT INTO public.keycloak_role VALUES ('ed68f12f-58e3-4d87-9a9d-f35246ca35b1', '3e938d5e-b26c-4e01-950d-cab2dce21b84', true, '${role_manage-account-links}', 'manage-account-links', 'master', '3e938d5e-b26c-4e01-950d-cab2dce21b84', NULL);
INSERT INTO public.keycloak_role VALUES ('7bbe9482-016c-45b3-a5b5-4691cc36622b', '90897f16-ce38-498b-abd0-df1a0f83b6db', true, '${role_read-token}', 'read-token', 'master', '90897f16-ce38-498b-abd0-df1a0f83b6db', NULL);
INSERT INTO public.keycloak_role VALUES ('96ae1f0f-7885-48a4-9cd7-48b265b359ef', '07604804-df43-4293-803b-f657b7d5b96e', true, '${role_impersonation}', 'impersonation', 'master', '07604804-df43-4293-803b-f657b7d5b96e', NULL);
INSERT INTO public.keycloak_role VALUES ('d4b04fdd-204c-4624-ad90-7930b326e61f', 'master', false, '${role_offline-access}', 'offline_access', 'master', NULL, 'master');
INSERT INTO public.keycloak_role VALUES ('dba9aa41-dbd5-4932-9bd8-8167276280d3', 'master', false, '${role_uma_authorization}', 'uma_authorization', 'master', NULL, 'master');
INSERT INTO public.keycloak_role VALUES ('e1293321-8c13-4e38-89ae-8362746acabc', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_create-client}', 'create-client', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('66e8062b-3563-4bef-94e5-3a99ea80f14d', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_view-realm}', 'view-realm', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('88bad5ee-f759-4297-8af9-30fa68343e56', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_view-users}', 'view-users', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('9d96ab11-dfde-4021-af16-3c687f57f46f', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_view-clients}', 'view-clients', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('93ac963d-c097-4ffc-a063-33a5803f9051', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_view-events}', 'view-events', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('f6b37477-fc5e-41f8-9d06-2fe8b641c8ba', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('b01216aa-31f0-4f8b-93fa-4ff576e4cc62', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_view-authorization}', 'view-authorization', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('b1f6de73-4011-4b4d-a252-cb8a67098dfb', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_manage-realm}', 'manage-realm', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('718eabb3-c6bf-4a48-bf12-051f5332aeb8', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_manage-users}', 'manage-users', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('471fcd8f-7147-45eb-8841-7c099971c567', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_manage-clients}', 'manage-clients', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('de6242de-152b-42b8-b540-13cdd085b827', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_manage-events}', 'manage-events', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('1d3a0972-e1eb-4d96-b04a-0379b9ed1b60', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('01bdeaa1-d018-4ce9-a3fa-3e135c83363f', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_manage-authorization}', 'manage-authorization', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('9cfd51d7-d871-469b-bd7a-763a1927d463', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_query-users}', 'query-users', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('d74e3acd-9f9a-4c50-95b2-250210043372', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_query-clients}', 'query-clients', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('42e0ee66-c7c2-4f2e-9392-4c1df882e0a9', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_query-realms}', 'query-realms', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('51e239b0-cbb5-4524-a839-5500fef62d12', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_query-groups}', 'query-groups', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('ad826f2c-d861-43bd-a8fd-edd4acabdf6f', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_realm-admin}', 'realm-admin', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('7abadb2e-1e6e-451d-a615-8717db4349c8', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_create-client}', 'create-client', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('eae3a136-55e9-4097-a76c-9c0d5c6575a5', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_view-realm}', 'view-realm', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('9c558947-41af-40e2-973c-5368f590d37b', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_view-users}', 'view-users', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('9ad72f04-f84c-45f9-807f-5a18796032b0', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_view-clients}', 'view-clients', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('d80242b2-dd70-4a9b-8199-c1f6f4cba670', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_view-events}', 'view-events', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('5da9b4c1-a0f6-4bb6-a023-6ae528ae5833', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_view-identity-providers}', 'view-identity-providers', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('6a174db8-6fc1-462b-a642-6d0570b18f7d', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_view-authorization}', 'view-authorization', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('6ef758e3-01ba-4b4d-9f59-7b2a475375e8', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_manage-realm}', 'manage-realm', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('f4135766-c531-4805-879e-4ba22aeb8e9c', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_manage-users}', 'manage-users', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('f88b7263-9d16-43c5-9149-f6d9626df1da', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_manage-clients}', 'manage-clients', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('2d1acbc9-729f-4329-9571-c82a95937cb9', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_manage-events}', 'manage-events', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('db3c191c-d79f-451c-ae5e-27d9134efcf4', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('a640bd3a-cb7c-42a8-84b6-6c8ac04693ea', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_manage-authorization}', 'manage-authorization', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('701a704d-e3ee-423f-a711-c0990dac9f08', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_query-users}', 'query-users', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('b55fcc40-160c-4467-8510-f2c586d1a854', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_query-clients}', 'query-clients', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('8d526714-84ec-42ab-8f20-453e71385aa9', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_query-realms}', 'query-realms', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('04eec52b-5d9f-427a-a31d-f26b5c882221', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_query-groups}', 'query-groups', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('ea65a121-b1a6-4cff-a916-7b9c710ea7cf', 'bdcfb968-249b-4d81-994f-40cc248fe756', true, '${role_view-profile}', 'view-profile', 'my_realm', 'bdcfb968-249b-4d81-994f-40cc248fe756', NULL);
INSERT INTO public.keycloak_role VALUES ('46a226ad-497e-44a9-8ed6-ee91c7b87c4e', 'bdcfb968-249b-4d81-994f-40cc248fe756', true, '${role_manage-account}', 'manage-account', 'my_realm', 'bdcfb968-249b-4d81-994f-40cc248fe756', NULL);
INSERT INTO public.keycloak_role VALUES ('d5bfd355-0365-4f62-8557-8bd1f6d0edfc', 'bdcfb968-249b-4d81-994f-40cc248fe756', true, '${role_manage-account-links}', 'manage-account-links', 'my_realm', 'bdcfb968-249b-4d81-994f-40cc248fe756', NULL);
INSERT INTO public.keycloak_role VALUES ('64f70066-84e7-477c-89c5-55aa07cd4d12', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', true, '${role_impersonation}', 'impersonation', 'master', 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', NULL);
INSERT INTO public.keycloak_role VALUES ('23419795-e85f-48d5-b018-31194e2c8b00', '9186b3e7-e5e7-4f08-8505-570149b2e740', true, '${role_impersonation}', 'impersonation', 'my_realm', '9186b3e7-e5e7-4f08-8505-570149b2e740', NULL);
INSERT INTO public.keycloak_role VALUES ('e6ff4553-7a5f-4c8d-b0a8-127a074050e9', 'd997ff0b-7e46-4cac-9945-b7f070c09e77', true, '${role_read-token}', 'read-token', 'my_realm', 'd997ff0b-7e46-4cac-9945-b7f070c09e77', NULL);
INSERT INTO public.keycloak_role VALUES ('8057a484-a6f7-45af-b028-8700dfcfe7b7', 'my_realm', false, '${role_offline-access}', 'offline_access', 'my_realm', NULL, 'my_realm');
INSERT INTO public.keycloak_role VALUES ('272e5eef-850f-4449-ab2c-e04a6ee89b07', 'my_realm', false, '${role_uma_authorization}', 'uma_authorization', 'my_realm', NULL, 'my_realm');


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.migration_model VALUES ('8unb6', '8.0.1', 1578990506);


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.protocol_mapper VALUES ('751faab9-5d32-4c01-be06-f9d79a26ade3', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', 'ec59c692-b0b0-40db-8ae4-27f97997d5f7', NULL);
INSERT INTO public.protocol_mapper VALUES ('3ed4fbf7-14ab-466e-b53f-8a566058178b', 'role list', 'saml', 'saml-role-list-mapper', NULL, '68572a70-8caa-4133-ab6d-6ee4cc4fc823');
INSERT INTO public.protocol_mapper VALUES ('71577f7b-f2c5-4d4e-9798-794316718d17', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('fba3f401-90dd-4d66-95c8-e59353e10dad', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('3c426328-140f-41e3-bb85-e0ae06c0c5b1', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('d6c7c298-46db-4c78-a084-fab8ca0f1145', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('16cab79a-c286-4890-812c-797c749ddb79', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('7770ce21-a3bb-47dd-910c-f39d00993d3d', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('f12f14c8-3f7e-46bf-9a2e-d044b179fa26', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('3a0ec787-81e0-4f89-b19b-e725a753ff9a', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('4333cc88-8cf3-4a99-9fd1-a415eeaa6ca1', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('4327ceb8-7673-4d7f-986c-51c00d2731e5', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('0c985b21-a8fa-4189-89c6-21c162c45e51', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('a5f2a87c-2622-4f3c-9bb1-a5c295555378', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('a25c737f-73e4-473a-aa50-e5c938433d45', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('bccc5dd9-21e2-4c85-ae18-3408fb8c82ee', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a62a2286-17be-4c14-9f0e-95b674e68d35');
INSERT INTO public.protocol_mapper VALUES ('5debdeba-9482-45e0-b6f8-dd07b3a9704f', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '44902f57-993d-4987-9e63-c98ff9fd0d2f');
INSERT INTO public.protocol_mapper VALUES ('fb5034f8-0e96-429e-a263-810f18deb84e', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '44902f57-993d-4987-9e63-c98ff9fd0d2f');
INSERT INTO public.protocol_mapper VALUES ('ba52d659-2217-43fd-885e-adbccb90e6f5', 'address', 'openid-connect', 'oidc-address-mapper', NULL, 'cefa2dca-d8a1-4d58-9715-b1fedb03cf2f');
INSERT INTO public.protocol_mapper VALUES ('1cd37336-04ba-4ba9-9bf5-7c68a01dcce7', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '6dfef3b0-6fe1-4a76-afa5-bccb894006f7');
INSERT INTO public.protocol_mapper VALUES ('c8c8697d-444b-4499-b3d8-4f6c8ff06f50', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '6dfef3b0-6fe1-4a76-afa5-bccb894006f7');
INSERT INTO public.protocol_mapper VALUES ('160ebe0a-156a-4866-a9e0-d983d1aacee6', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '68eabe34-176c-4075-a9aa-bf373f064ba0');
INSERT INTO public.protocol_mapper VALUES ('5b194445-bb4b-45da-a372-a28b1fc8a6de', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '68eabe34-176c-4075-a9aa-bf373f064ba0');
INSERT INTO public.protocol_mapper VALUES ('f652f8b0-4df1-4a2a-8f7b-054ecb1ad0ce', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '68eabe34-176c-4075-a9aa-bf373f064ba0');
INSERT INTO public.protocol_mapper VALUES ('16433c13-f77a-49f8-aecd-eb0b80ada8e7', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, 'a6419ed3-4fd2-4e8d-a9d0-02f8e0d0ae95');
INSERT INTO public.protocol_mapper VALUES ('789e83c0-1652-4b2e-ad5d-6d13e2b6b752', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd');
INSERT INTO public.protocol_mapper VALUES ('0a7782f9-8528-4670-afbb-96d820335da7', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'c5d059d4-3c1d-4f67-a0c7-6f5b308f70dd');
INSERT INTO public.protocol_mapper VALUES ('96cf20c4-601b-40fc-8052-768ba7d20db2', 'role list', 'saml', 'saml-role-list-mapper', NULL, 'd0935e0d-5613-4699-976e-dce6aaa735d5');
INSERT INTO public.protocol_mapper VALUES ('04ad8a91-d389-4889-aa06-e10986859ddd', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('7d2e9974-529c-44ae-acc9-a1d7eb997dde', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('ce88aa25-3be2-4540-aaa5-c3928ec49994', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('bb522b19-a779-4a93-9a79-cd30db6acafe', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('7c772e39-685e-4096-b900-e9e4a9361270', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('8f276499-d434-4f61-8caa-6cd9f1a73068', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('260cf88a-ac4d-47a7-98a5-adbc2ba13372', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('233c1fa1-1195-46c0-806b-d69159710351', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('a2313610-2302-494c-b482-10b89ec023ef', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('146236e7-9fcb-45f4-a8ac-ccab0bead143', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('461bf73e-424b-4763-9e79-50a3637b4d96', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('3c7cb33d-775c-4c48-aee3-04c770757564', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('865fa0d8-f976-4b07-8a93-14fd5f734ddb', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('045e2a50-ed95-4e3c-9d44-95948e973edc', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '602f1759-5b71-4507-8fe1-c394ec186ac0');
INSERT INTO public.protocol_mapper VALUES ('1cae984a-fde8-4715-b2bc-0888f046e2f0', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '53cb249b-316a-461b-81bc-43f02f3b643f');
INSERT INTO public.protocol_mapper VALUES ('27ad170c-a3b5-4b5f-9bc4-2fb6a748c2d6', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '53cb249b-316a-461b-81bc-43f02f3b643f');
INSERT INTO public.protocol_mapper VALUES ('9cad9c32-b023-433e-b943-bff4e90b8278', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '74927a2e-4aaf-4666-ba11-7356382bacad');
INSERT INTO public.protocol_mapper VALUES ('3644d274-e921-45dd-bba4-5dbc2db9d209', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'b2ca3287-fa66-4708-b3fa-1d98a47fbd88');
INSERT INTO public.protocol_mapper VALUES ('63816af8-724f-456a-91ca-436226a8286b', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'b2ca3287-fa66-4708-b3fa-1d98a47fbd88');
INSERT INTO public.protocol_mapper VALUES ('3c1008f9-deb5-4acd-80ff-68e8347afacc', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '1a58966d-0df4-469b-b05f-a0a57c9e3588');
INSERT INTO public.protocol_mapper VALUES ('2910be63-3baf-4688-a358-42ed09eb492c', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '1a58966d-0df4-469b-b05f-a0a57c9e3588');
INSERT INTO public.protocol_mapper VALUES ('a21dad21-d382-45a2-bd03-ddb72167c3c6', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '1a58966d-0df4-469b-b05f-a0a57c9e3588');
INSERT INTO public.protocol_mapper VALUES ('a2c93d41-2dbf-4d16-b43d-2b0fed8df8de', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '4ad5b5d0-53e8-4681-827c-95d193f27949');
INSERT INTO public.protocol_mapper VALUES ('b4afa298-dc99-4e8d-8cd9-76777b52c2ea', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'b923fc2d-1f91-47dc-9eb6-a3683edde275');
INSERT INTO public.protocol_mapper VALUES ('3596d490-b65c-4bca-a2fc-775c331fe3c2', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'b923fc2d-1f91-47dc-9eb6-a3683edde275');
INSERT INTO public.protocol_mapper VALUES ('c973c622-abd0-4320-937f-dedb0457a5f8', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '84aa3db8-2c06-4559-a623-a2ce0671eb68', NULL);


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.protocol_mapper_config VALUES ('751faab9-5d32-4c01-be06-f9d79a26ade3', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('751faab9-5d32-4c01-be06-f9d79a26ade3', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('751faab9-5d32-4c01-be06-f9d79a26ade3', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('751faab9-5d32-4c01-be06-f9d79a26ade3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('751faab9-5d32-4c01-be06-f9d79a26ade3', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('751faab9-5d32-4c01-be06-f9d79a26ade3', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('3ed4fbf7-14ab-466e-b53f-8a566058178b', 'false', 'single');
INSERT INTO public.protocol_mapper_config VALUES ('3ed4fbf7-14ab-466e-b53f-8a566058178b', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config VALUES ('3ed4fbf7-14ab-466e-b53f-8a566058178b', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config VALUES ('71577f7b-f2c5-4d4e-9798-794316718d17', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('71577f7b-f2c5-4d4e-9798-794316718d17', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('71577f7b-f2c5-4d4e-9798-794316718d17', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fba3f401-90dd-4d66-95c8-e59353e10dad', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fba3f401-90dd-4d66-95c8-e59353e10dad', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('fba3f401-90dd-4d66-95c8-e59353e10dad', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fba3f401-90dd-4d66-95c8-e59353e10dad', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fba3f401-90dd-4d66-95c8-e59353e10dad', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('fba3f401-90dd-4d66-95c8-e59353e10dad', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('3c426328-140f-41e3-bb85-e0ae06c0c5b1', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3c426328-140f-41e3-bb85-e0ae06c0c5b1', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('3c426328-140f-41e3-bb85-e0ae06c0c5b1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3c426328-140f-41e3-bb85-e0ae06c0c5b1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3c426328-140f-41e3-bb85-e0ae06c0c5b1', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('3c426328-140f-41e3-bb85-e0ae06c0c5b1', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d6c7c298-46db-4c78-a084-fab8ca0f1145', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6c7c298-46db-4c78-a084-fab8ca0f1145', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('d6c7c298-46db-4c78-a084-fab8ca0f1145', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6c7c298-46db-4c78-a084-fab8ca0f1145', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6c7c298-46db-4c78-a084-fab8ca0f1145', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('d6c7c298-46db-4c78-a084-fab8ca0f1145', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('16cab79a-c286-4890-812c-797c749ddb79', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('16cab79a-c286-4890-812c-797c749ddb79', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('16cab79a-c286-4890-812c-797c749ddb79', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('16cab79a-c286-4890-812c-797c749ddb79', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('16cab79a-c286-4890-812c-797c749ddb79', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('16cab79a-c286-4890-812c-797c749ddb79', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('7770ce21-a3bb-47dd-910c-f39d00993d3d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7770ce21-a3bb-47dd-910c-f39d00993d3d', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('7770ce21-a3bb-47dd-910c-f39d00993d3d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7770ce21-a3bb-47dd-910c-f39d00993d3d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7770ce21-a3bb-47dd-910c-f39d00993d3d', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('7770ce21-a3bb-47dd-910c-f39d00993d3d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('f12f14c8-3f7e-46bf-9a2e-d044b179fa26', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f12f14c8-3f7e-46bf-9a2e-d044b179fa26', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('f12f14c8-3f7e-46bf-9a2e-d044b179fa26', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f12f14c8-3f7e-46bf-9a2e-d044b179fa26', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f12f14c8-3f7e-46bf-9a2e-d044b179fa26', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('f12f14c8-3f7e-46bf-9a2e-d044b179fa26', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('3a0ec787-81e0-4f89-b19b-e725a753ff9a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3a0ec787-81e0-4f89-b19b-e725a753ff9a', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('3a0ec787-81e0-4f89-b19b-e725a753ff9a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3a0ec787-81e0-4f89-b19b-e725a753ff9a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3a0ec787-81e0-4f89-b19b-e725a753ff9a', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('3a0ec787-81e0-4f89-b19b-e725a753ff9a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('4333cc88-8cf3-4a99-9fd1-a415eeaa6ca1', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4333cc88-8cf3-4a99-9fd1-a415eeaa6ca1', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('4333cc88-8cf3-4a99-9fd1-a415eeaa6ca1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4333cc88-8cf3-4a99-9fd1-a415eeaa6ca1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4333cc88-8cf3-4a99-9fd1-a415eeaa6ca1', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('4333cc88-8cf3-4a99-9fd1-a415eeaa6ca1', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('4327ceb8-7673-4d7f-986c-51c00d2731e5', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4327ceb8-7673-4d7f-986c-51c00d2731e5', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('4327ceb8-7673-4d7f-986c-51c00d2731e5', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4327ceb8-7673-4d7f-986c-51c00d2731e5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4327ceb8-7673-4d7f-986c-51c00d2731e5', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('4327ceb8-7673-4d7f-986c-51c00d2731e5', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('0c985b21-a8fa-4189-89c6-21c162c45e51', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0c985b21-a8fa-4189-89c6-21c162c45e51', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('0c985b21-a8fa-4189-89c6-21c162c45e51', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0c985b21-a8fa-4189-89c6-21c162c45e51', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0c985b21-a8fa-4189-89c6-21c162c45e51', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('0c985b21-a8fa-4189-89c6-21c162c45e51', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a5f2a87c-2622-4f3c-9bb1-a5c295555378', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a5f2a87c-2622-4f3c-9bb1-a5c295555378', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('a5f2a87c-2622-4f3c-9bb1-a5c295555378', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a5f2a87c-2622-4f3c-9bb1-a5c295555378', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a5f2a87c-2622-4f3c-9bb1-a5c295555378', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('a5f2a87c-2622-4f3c-9bb1-a5c295555378', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a25c737f-73e4-473a-aa50-e5c938433d45', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a25c737f-73e4-473a-aa50-e5c938433d45', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('a25c737f-73e4-473a-aa50-e5c938433d45', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a25c737f-73e4-473a-aa50-e5c938433d45', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a25c737f-73e4-473a-aa50-e5c938433d45', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('a25c737f-73e4-473a-aa50-e5c938433d45', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('bccc5dd9-21e2-4c85-ae18-3408fb8c82ee', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bccc5dd9-21e2-4c85-ae18-3408fb8c82ee', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('bccc5dd9-21e2-4c85-ae18-3408fb8c82ee', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bccc5dd9-21e2-4c85-ae18-3408fb8c82ee', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bccc5dd9-21e2-4c85-ae18-3408fb8c82ee', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('bccc5dd9-21e2-4c85-ae18-3408fb8c82ee', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('5debdeba-9482-45e0-b6f8-dd07b3a9704f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5debdeba-9482-45e0-b6f8-dd07b3a9704f', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('5debdeba-9482-45e0-b6f8-dd07b3a9704f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5debdeba-9482-45e0-b6f8-dd07b3a9704f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5debdeba-9482-45e0-b6f8-dd07b3a9704f', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('5debdeba-9482-45e0-b6f8-dd07b3a9704f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('fb5034f8-0e96-429e-a263-810f18deb84e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fb5034f8-0e96-429e-a263-810f18deb84e', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('fb5034f8-0e96-429e-a263-810f18deb84e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fb5034f8-0e96-429e-a263-810f18deb84e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fb5034f8-0e96-429e-a263-810f18deb84e', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('fb5034f8-0e96-429e-a263-810f18deb84e', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('ba52d659-2217-43fd-885e-adbccb90e6f5', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config VALUES ('ba52d659-2217-43fd-885e-adbccb90e6f5', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config VALUES ('ba52d659-2217-43fd-885e-adbccb90e6f5', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config VALUES ('ba52d659-2217-43fd-885e-adbccb90e6f5', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ba52d659-2217-43fd-885e-adbccb90e6f5', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config VALUES ('ba52d659-2217-43fd-885e-adbccb90e6f5', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ba52d659-2217-43fd-885e-adbccb90e6f5', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config VALUES ('ba52d659-2217-43fd-885e-adbccb90e6f5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ba52d659-2217-43fd-885e-adbccb90e6f5', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config VALUES ('1cd37336-04ba-4ba9-9bf5-7c68a01dcce7', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1cd37336-04ba-4ba9-9bf5-7c68a01dcce7', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('1cd37336-04ba-4ba9-9bf5-7c68a01dcce7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1cd37336-04ba-4ba9-9bf5-7c68a01dcce7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1cd37336-04ba-4ba9-9bf5-7c68a01dcce7', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('1cd37336-04ba-4ba9-9bf5-7c68a01dcce7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c8c8697d-444b-4499-b3d8-4f6c8ff06f50', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c8c8697d-444b-4499-b3d8-4f6c8ff06f50', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('c8c8697d-444b-4499-b3d8-4f6c8ff06f50', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c8c8697d-444b-4499-b3d8-4f6c8ff06f50', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c8c8697d-444b-4499-b3d8-4f6c8ff06f50', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('c8c8697d-444b-4499-b3d8-4f6c8ff06f50', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('160ebe0a-156a-4866-a9e0-d983d1aacee6', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('160ebe0a-156a-4866-a9e0-d983d1aacee6', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('160ebe0a-156a-4866-a9e0-d983d1aacee6', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('160ebe0a-156a-4866-a9e0-d983d1aacee6', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('160ebe0a-156a-4866-a9e0-d983d1aacee6', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('5b194445-bb4b-45da-a372-a28b1fc8a6de', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('5b194445-bb4b-45da-a372-a28b1fc8a6de', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('5b194445-bb4b-45da-a372-a28b1fc8a6de', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5b194445-bb4b-45da-a372-a28b1fc8a6de', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('5b194445-bb4b-45da-a372-a28b1fc8a6de', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('789e83c0-1652-4b2e-ad5d-6d13e2b6b752', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('789e83c0-1652-4b2e-ad5d-6d13e2b6b752', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('789e83c0-1652-4b2e-ad5d-6d13e2b6b752', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('789e83c0-1652-4b2e-ad5d-6d13e2b6b752', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('789e83c0-1652-4b2e-ad5d-6d13e2b6b752', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('789e83c0-1652-4b2e-ad5d-6d13e2b6b752', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('0a7782f9-8528-4670-afbb-96d820335da7', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('0a7782f9-8528-4670-afbb-96d820335da7', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('0a7782f9-8528-4670-afbb-96d820335da7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0a7782f9-8528-4670-afbb-96d820335da7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0a7782f9-8528-4670-afbb-96d820335da7', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('0a7782f9-8528-4670-afbb-96d820335da7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('96cf20c4-601b-40fc-8052-768ba7d20db2', 'false', 'single');
INSERT INTO public.protocol_mapper_config VALUES ('96cf20c4-601b-40fc-8052-768ba7d20db2', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config VALUES ('96cf20c4-601b-40fc-8052-768ba7d20db2', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config VALUES ('04ad8a91-d389-4889-aa06-e10986859ddd', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('04ad8a91-d389-4889-aa06-e10986859ddd', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('04ad8a91-d389-4889-aa06-e10986859ddd', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7d2e9974-529c-44ae-acc9-a1d7eb997dde', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7d2e9974-529c-44ae-acc9-a1d7eb997dde', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('7d2e9974-529c-44ae-acc9-a1d7eb997dde', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7d2e9974-529c-44ae-acc9-a1d7eb997dde', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7d2e9974-529c-44ae-acc9-a1d7eb997dde', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('7d2e9974-529c-44ae-acc9-a1d7eb997dde', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('ce88aa25-3be2-4540-aaa5-c3928ec49994', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ce88aa25-3be2-4540-aaa5-c3928ec49994', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('ce88aa25-3be2-4540-aaa5-c3928ec49994', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ce88aa25-3be2-4540-aaa5-c3928ec49994', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ce88aa25-3be2-4540-aaa5-c3928ec49994', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('ce88aa25-3be2-4540-aaa5-c3928ec49994', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('bb522b19-a779-4a93-9a79-cd30db6acafe', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb522b19-a779-4a93-9a79-cd30db6acafe', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('bb522b19-a779-4a93-9a79-cd30db6acafe', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb522b19-a779-4a93-9a79-cd30db6acafe', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb522b19-a779-4a93-9a79-cd30db6acafe', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('bb522b19-a779-4a93-9a79-cd30db6acafe', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('7c772e39-685e-4096-b900-e9e4a9361270', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7c772e39-685e-4096-b900-e9e4a9361270', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('7c772e39-685e-4096-b900-e9e4a9361270', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7c772e39-685e-4096-b900-e9e4a9361270', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7c772e39-685e-4096-b900-e9e4a9361270', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('7c772e39-685e-4096-b900-e9e4a9361270', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('8f276499-d434-4f61-8caa-6cd9f1a73068', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8f276499-d434-4f61-8caa-6cd9f1a73068', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('8f276499-d434-4f61-8caa-6cd9f1a73068', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8f276499-d434-4f61-8caa-6cd9f1a73068', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8f276499-d434-4f61-8caa-6cd9f1a73068', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('8f276499-d434-4f61-8caa-6cd9f1a73068', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('260cf88a-ac4d-47a7-98a5-adbc2ba13372', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('260cf88a-ac4d-47a7-98a5-adbc2ba13372', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('260cf88a-ac4d-47a7-98a5-adbc2ba13372', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('260cf88a-ac4d-47a7-98a5-adbc2ba13372', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('260cf88a-ac4d-47a7-98a5-adbc2ba13372', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('260cf88a-ac4d-47a7-98a5-adbc2ba13372', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('233c1fa1-1195-46c0-806b-d69159710351', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('233c1fa1-1195-46c0-806b-d69159710351', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('233c1fa1-1195-46c0-806b-d69159710351', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('233c1fa1-1195-46c0-806b-d69159710351', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('233c1fa1-1195-46c0-806b-d69159710351', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('233c1fa1-1195-46c0-806b-d69159710351', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a2313610-2302-494c-b482-10b89ec023ef', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a2313610-2302-494c-b482-10b89ec023ef', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('a2313610-2302-494c-b482-10b89ec023ef', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a2313610-2302-494c-b482-10b89ec023ef', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a2313610-2302-494c-b482-10b89ec023ef', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('a2313610-2302-494c-b482-10b89ec023ef', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('146236e7-9fcb-45f4-a8ac-ccab0bead143', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('146236e7-9fcb-45f4-a8ac-ccab0bead143', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('146236e7-9fcb-45f4-a8ac-ccab0bead143', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('146236e7-9fcb-45f4-a8ac-ccab0bead143', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('146236e7-9fcb-45f4-a8ac-ccab0bead143', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('146236e7-9fcb-45f4-a8ac-ccab0bead143', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('461bf73e-424b-4763-9e79-50a3637b4d96', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('461bf73e-424b-4763-9e79-50a3637b4d96', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('461bf73e-424b-4763-9e79-50a3637b4d96', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('461bf73e-424b-4763-9e79-50a3637b4d96', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('461bf73e-424b-4763-9e79-50a3637b4d96', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('461bf73e-424b-4763-9e79-50a3637b4d96', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('3c7cb33d-775c-4c48-aee3-04c770757564', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3c7cb33d-775c-4c48-aee3-04c770757564', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('3c7cb33d-775c-4c48-aee3-04c770757564', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3c7cb33d-775c-4c48-aee3-04c770757564', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3c7cb33d-775c-4c48-aee3-04c770757564', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('3c7cb33d-775c-4c48-aee3-04c770757564', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('865fa0d8-f976-4b07-8a93-14fd5f734ddb', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('865fa0d8-f976-4b07-8a93-14fd5f734ddb', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('865fa0d8-f976-4b07-8a93-14fd5f734ddb', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('865fa0d8-f976-4b07-8a93-14fd5f734ddb', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('865fa0d8-f976-4b07-8a93-14fd5f734ddb', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('865fa0d8-f976-4b07-8a93-14fd5f734ddb', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('045e2a50-ed95-4e3c-9d44-95948e973edc', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('045e2a50-ed95-4e3c-9d44-95948e973edc', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('045e2a50-ed95-4e3c-9d44-95948e973edc', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('045e2a50-ed95-4e3c-9d44-95948e973edc', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('045e2a50-ed95-4e3c-9d44-95948e973edc', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('045e2a50-ed95-4e3c-9d44-95948e973edc', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('1cae984a-fde8-4715-b2bc-0888f046e2f0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1cae984a-fde8-4715-b2bc-0888f046e2f0', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('1cae984a-fde8-4715-b2bc-0888f046e2f0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1cae984a-fde8-4715-b2bc-0888f046e2f0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1cae984a-fde8-4715-b2bc-0888f046e2f0', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('1cae984a-fde8-4715-b2bc-0888f046e2f0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('27ad170c-a3b5-4b5f-9bc4-2fb6a748c2d6', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27ad170c-a3b5-4b5f-9bc4-2fb6a748c2d6', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('27ad170c-a3b5-4b5f-9bc4-2fb6a748c2d6', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27ad170c-a3b5-4b5f-9bc4-2fb6a748c2d6', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27ad170c-a3b5-4b5f-9bc4-2fb6a748c2d6', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('27ad170c-a3b5-4b5f-9bc4-2fb6a748c2d6', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('9cad9c32-b023-433e-b943-bff4e90b8278', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config VALUES ('9cad9c32-b023-433e-b943-bff4e90b8278', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config VALUES ('9cad9c32-b023-433e-b943-bff4e90b8278', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config VALUES ('9cad9c32-b023-433e-b943-bff4e90b8278', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9cad9c32-b023-433e-b943-bff4e90b8278', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config VALUES ('9cad9c32-b023-433e-b943-bff4e90b8278', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9cad9c32-b023-433e-b943-bff4e90b8278', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config VALUES ('9cad9c32-b023-433e-b943-bff4e90b8278', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9cad9c32-b023-433e-b943-bff4e90b8278', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config VALUES ('3644d274-e921-45dd-bba4-5dbc2db9d209', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3644d274-e921-45dd-bba4-5dbc2db9d209', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('3644d274-e921-45dd-bba4-5dbc2db9d209', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3644d274-e921-45dd-bba4-5dbc2db9d209', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3644d274-e921-45dd-bba4-5dbc2db9d209', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('3644d274-e921-45dd-bba4-5dbc2db9d209', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('63816af8-724f-456a-91ca-436226a8286b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('63816af8-724f-456a-91ca-436226a8286b', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('63816af8-724f-456a-91ca-436226a8286b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('63816af8-724f-456a-91ca-436226a8286b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('63816af8-724f-456a-91ca-436226a8286b', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('63816af8-724f-456a-91ca-436226a8286b', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('3c1008f9-deb5-4acd-80ff-68e8347afacc', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('3c1008f9-deb5-4acd-80ff-68e8347afacc', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('3c1008f9-deb5-4acd-80ff-68e8347afacc', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3c1008f9-deb5-4acd-80ff-68e8347afacc', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('3c1008f9-deb5-4acd-80ff-68e8347afacc', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('2910be63-3baf-4688-a358-42ed09eb492c', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('2910be63-3baf-4688-a358-42ed09eb492c', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('2910be63-3baf-4688-a358-42ed09eb492c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2910be63-3baf-4688-a358-42ed09eb492c', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('2910be63-3baf-4688-a358-42ed09eb492c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('b4afa298-dc99-4e8d-8cd9-76777b52c2ea', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b4afa298-dc99-4e8d-8cd9-76777b52c2ea', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('b4afa298-dc99-4e8d-8cd9-76777b52c2ea', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b4afa298-dc99-4e8d-8cd9-76777b52c2ea', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b4afa298-dc99-4e8d-8cd9-76777b52c2ea', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('b4afa298-dc99-4e8d-8cd9-76777b52c2ea', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('3596d490-b65c-4bca-a2fc-775c331fe3c2', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('3596d490-b65c-4bca-a2fc-775c331fe3c2', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('3596d490-b65c-4bca-a2fc-775c331fe3c2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3596d490-b65c-4bca-a2fc-775c331fe3c2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3596d490-b65c-4bca-a2fc-775c331fe3c2', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('3596d490-b65c-4bca-a2fc-775c331fe3c2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c973c622-abd0-4320-937f-dedb0457a5f8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c973c622-abd0-4320-937f-dedb0457a5f8', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('c973c622-abd0-4320-937f-dedb0457a5f8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c973c622-abd0-4320-937f-dedb0457a5f8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c973c622-abd0-4320-937f-dedb0457a5f8', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('c973c622-abd0-4320-937f-dedb0457a5f8', 'String', 'jsonType.label');


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.realm VALUES ('master', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '07604804-df43-4293-803b-f657b7d5b96e', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '99544bd4-9f18-4704-9791-8f7867254ef0', '83f9ce39-1510-4013-b292-7440a5c6657f', '9bf29e2d-70f7-4361-a9b6-e33b13f6c484', 'fabd4128-5554-4bb0-860c-b0d45405e4f6', 'c088ba32-4e55-47fc-b7bf-3ec0c75b1490', 2592000, false, 900, true, false, '31a3af24-3c87-4ef3-bede-fe32b73b530f', 0, false, 0, 0);
INSERT INTO public.realm VALUES ('my_realm', 60, 300, 300, NULL, NULL, NULL, true, false, 0, NULL, 'my_realm', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'cc53c62a-6372-4e9b-85fa-ea3aa4ef9aaf', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '14945055-57a6-475b-9300-509bcf3add0a', 'd2648224-61a1-499a-89c5-89a9505bf4d2', 'e4feb7bf-e017-4d64-8a58-b0ca85c57777', '864f918f-c701-4f48-92fb-6a26a949113b', 'a909ec97-4ba9-445e-9ba5-1765cf5c36bc', 2592000, false, 900, true, false, '1e784c99-a87a-440f-9dc0-9dfe2f3cb913', 0, false, 0, 0);


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', '', 'master');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'nosniff', 'master');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xRobotsTag', 'none', 'master');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xFrameOptions', 'SAMEORIGIN', 'master');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';', 'master');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xXSSProtection', '1; mode=block', 'master');
INSERT INTO public.realm_attribute VALUES ('_browser_header.strictTransportSecurity', 'max-age=31536000; includeSubDomains', 'master');
INSERT INTO public.realm_attribute VALUES ('bruteForceProtected', 'false', 'master');
INSERT INTO public.realm_attribute VALUES ('permanentLockout', 'false', 'master');
INSERT INTO public.realm_attribute VALUES ('maxFailureWaitSeconds', '900', 'master');
INSERT INTO public.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', '60', 'master');
INSERT INTO public.realm_attribute VALUES ('waitIncrementSeconds', '60', 'master');
INSERT INTO public.realm_attribute VALUES ('quickLoginCheckMilliSeconds', '1000', 'master');
INSERT INTO public.realm_attribute VALUES ('maxDeltaTimeSeconds', '43200', 'master');
INSERT INTO public.realm_attribute VALUES ('failureFactor', '30', 'master');
INSERT INTO public.realm_attribute VALUES ('displayName', 'Keycloak', 'master');
INSERT INTO public.realm_attribute VALUES ('displayNameHtml', '<div class="kc-logo-text"><span>Keycloak</span></div>', 'master');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', 'false', 'master');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespan', '5184000', 'master');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', '', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'nosniff', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xRobotsTag', 'none', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xFrameOptions', 'SAMEORIGIN', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xXSSProtection', '1; mode=block', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('_browser_header.strictTransportSecurity', 'max-age=31536000; includeSubDomains', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('bruteForceProtected', 'false', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('permanentLockout', 'false', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('maxFailureWaitSeconds', '900', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', '60', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('waitIncrementSeconds', '60', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('quickLoginCheckMilliSeconds', '1000', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('maxDeltaTimeSeconds', '43200', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('failureFactor', '30', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', 'false', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespan', '5184000', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByAdminLifespan', '43200', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan', '300', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpEntityName', 'keycloak', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicySignatureAlgorithms', 'ES256', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpId', '', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAttestationConveyancePreference', 'not specified', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAuthenticatorAttachment', 'not specified', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRequireResidentKey', 'not specified', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyUserVerificationRequirement', 'not specified', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyCreateTimeout', '0', 'my_realm');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegister', 'false', 'my_realm');


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.realm_default_roles VALUES ('master', 'd4b04fdd-204c-4624-ad90-7930b326e61f');
INSERT INTO public.realm_default_roles VALUES ('master', 'dba9aa41-dbd5-4932-9bd8-8167276280d3');
INSERT INTO public.realm_default_roles VALUES ('my_realm', '8057a484-a6f7-45af-b028-8700dfcfe7b7');
INSERT INTO public.realm_default_roles VALUES ('my_realm', '272e5eef-850f-4449-ab2c-e04a6ee89b07');


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.realm_events_listeners VALUES ('master', 'jboss-logging');
INSERT INTO public.realm_events_listeners VALUES ('my_realm', 'jboss-logging');


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.realm_required_credential VALUES ('password', 'password', true, true, 'master');
INSERT INTO public.realm_required_credential VALUES ('password', 'password', true, true, 'my_realm');


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.redirect_uris VALUES ('3e938d5e-b26c-4e01-950d-cab2dce21b84', '/realms/master/account/*');
INSERT INTO public.redirect_uris VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', '/admin/master/console/*');
INSERT INTO public.redirect_uris VALUES ('bdcfb968-249b-4d81-994f-40cc248fe756', '/realms/my_realm/account/*');
INSERT INTO public.redirect_uris VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', '/admin/my_realm/console/*');
INSERT INTO public.redirect_uris VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'http://gw2sdev-docker.ovh.net:36610/*');


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.required_action_provider VALUES ('999c886e-cba8-4b74-ab2f-c6331b20c250', 'VERIFY_EMAIL', 'Verify Email', 'master', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider VALUES ('0cedd212-c1e6-4c9a-b64f-cc1853454a6d', 'UPDATE_PROFILE', 'Update Profile', 'master', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider VALUES ('1c2be123-3ae2-471c-9451-0afe4f091b56', 'CONFIGURE_TOTP', 'Configure OTP', 'master', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider VALUES ('cdde4e1b-0b65-4ac4-8d38-0f1a4893277b', 'UPDATE_PASSWORD', 'Update Password', 'master', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider VALUES ('29a0f25d-9934-4abe-8844-64cc584178f7', 'terms_and_conditions', 'Terms and Conditions', 'master', false, false, 'terms_and_conditions', 20);
INSERT INTO public.required_action_provider VALUES ('9d8ba279-696a-4262-8583-db01af6d30b0', 'VERIFY_EMAIL', 'Verify Email', 'my_realm', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider VALUES ('9202d306-6bb6-4b5b-b5bb-a13c8b814b14', 'UPDATE_PROFILE', 'Update Profile', 'my_realm', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider VALUES ('95a0abfc-948c-4edd-8398-c78776d20017', 'CONFIGURE_TOTP', 'Configure OTP', 'my_realm', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider VALUES ('963ffe9d-0a39-44bf-ba4f-5a7327b9127b', 'UPDATE_PASSWORD', 'Update Password', 'my_realm', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider VALUES ('b362dd1b-20ce-472f-a50d-0932c563c2b2', 'terms_and_conditions', 'Terms and Conditions', 'my_realm', false, false, 'terms_and_conditions', 20);


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.user_attribute VALUES ('custom-attribute', 'value of custom attribute', 'ba1ec4ba-47db-432f-879b-616fa2158b42', '2b9be6e7-a724-4e94-ad8a-6cec0386bc71');


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.user_entity VALUES ('dc59f130-565e-41d0-8f43-94e028566fe0', NULL, '53d45e00-9283-47ac-a45b-07c80cd4e40d', false, true, NULL, NULL, NULL, 'master', 'admin', 1578990508080, NULL, 0);
INSERT INTO public.user_entity VALUES ('ba1ec4ba-47db-432f-879b-616fa2158b42', 'demo@localhost', 'demo@localhost', false, true, NULL, 'Demo', 'User', 'my_realm', 'demo', 1578990604096, NULL, 0);


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.user_role_mapping VALUES ('dba9aa41-dbd5-4932-9bd8-8167276280d3', 'dc59f130-565e-41d0-8f43-94e028566fe0');
INSERT INTO public.user_role_mapping VALUES ('403e3cc6-7fe6-4e7d-b48e-8f585781adc6', 'dc59f130-565e-41d0-8f43-94e028566fe0');
INSERT INTO public.user_role_mapping VALUES ('d4b04fdd-204c-4624-ad90-7930b326e61f', 'dc59f130-565e-41d0-8f43-94e028566fe0');
INSERT INTO public.user_role_mapping VALUES ('fc1cd5e9-44de-48f2-83cb-69fec15ec0d5', 'dc59f130-565e-41d0-8f43-94e028566fe0');
INSERT INTO public.user_role_mapping VALUES ('c481e334-d0da-43ed-9fa3-f7d9556bcd58', 'dc59f130-565e-41d0-8f43-94e028566fe0');
INSERT INTO public.user_role_mapping VALUES ('46a226ad-497e-44a9-8ed6-ee91c7b87c4e', 'ba1ec4ba-47db-432f-879b-616fa2158b42');
INSERT INTO public.user_role_mapping VALUES ('ea65a121-b1a6-4cff-a916-7b9c710ea7cf', 'ba1ec4ba-47db-432f-879b-616fa2158b42');
INSERT INTO public.user_role_mapping VALUES ('8057a484-a6f7-45af-b028-8700dfcfe7b7', 'ba1ec4ba-47db-432f-879b-616fa2158b42');
INSERT INTO public.user_role_mapping VALUES ('272e5eef-850f-4449-ab2c-e04a6ee89b07', 'ba1ec4ba-47db-432f-879b-616fa2158b42');


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--



--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: cooking-assistant
--

INSERT INTO public.web_origins VALUES ('ec59c692-b0b0-40db-8ae4-27f97997d5f7', '+');
INSERT INTO public.web_origins VALUES ('84aa3db8-2c06-4559-a623-a2ce0671eb68', '+');
INSERT INTO public.web_origins VALUES ('f95e0cd2-2174-4c07-91a9-cb3b3071636c', 'http://gw2sdev-docker.ovh.net:36610');


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: cooking-assistant
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_role; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES public.client(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES public.client(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: cooking-assistant
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

