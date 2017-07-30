--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: gha_actors; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_actors (
    id bigint NOT NULL,
    login character varying(100) NOT NULL
);


ALTER TABLE gha_actors OWNER TO gha_admin;

--
-- Name: gha_assets; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_assets (
    id bigint NOT NULL,
    name character varying(160) NOT NULL,
    label character varying(40),
    uploader_id bigint NOT NULL,
    content_type character varying(80) NOT NULL,
    state character varying(20) NOT NULL,
    size integer NOT NULL,
    download_count integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE gha_assets OWNER TO gha_admin;

--
-- Name: gha_comments; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_comments (
    id bigint NOT NULL,
    body text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying(40) NOT NULL,
    user_id bigint NOT NULL,
    commit_id character varying(40),
    original_commit_id character varying(40),
    diff_hunk text,
    "position" integer,
    original_position integer,
    path text,
    pull_request_review_id bigint,
    line integer
);


ALTER TABLE gha_comments OWNER TO gha_admin;

--
-- Name: gha_commits; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_commits (
    sha character varying(40) NOT NULL,
    author_name character varying(160) NOT NULL,
    message text NOT NULL,
    is_distinct boolean NOT NULL
);


ALTER TABLE gha_commits OWNER TO gha_admin;

--
-- Name: gha_events; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_events (
    id bigint NOT NULL,
    type character varying(40) NOT NULL,
    actor_id bigint NOT NULL,
    repo_id bigint NOT NULL,
    payload_id bigint NOT NULL,
    public boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    org_id bigint
);


ALTER TABLE gha_events OWNER TO gha_admin;

--
-- Name: gha_forkees; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_forkees (
    id bigint NOT NULL,
    name character varying(80) NOT NULL,
    full_name character varying(160) NOT NULL,
    owner_id bigint NOT NULL,
    description text,
    fork boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    pushed_at timestamp without time zone NOT NULL,
    homepage text,
    size integer NOT NULL,
    stargazers_count integer NOT NULL,
    has_issues boolean NOT NULL,
    has_projects boolean NOT NULL,
    has_downloads boolean NOT NULL,
    has_wiki boolean NOT NULL,
    has_pages boolean NOT NULL,
    forks integer NOT NULL,
    open_issues integer NOT NULL,
    watchers integer NOT NULL,
    default_branch character varying(160) NOT NULL,
    public boolean NOT NULL
);


ALTER TABLE gha_forkees OWNER TO gha_admin;

--
-- Name: gha_issues; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_issues (
    id bigint NOT NULL,
    assignee_id bigint,
    body text,
    closed_at timestamp without time zone,
    comments integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    locked boolean NOT NULL,
    milestone_id bigint,
    number integer NOT NULL,
    state character varying(20) NOT NULL,
    title text NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE gha_issues OWNER TO gha_admin;

--
-- Name: gha_issues_assignees; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_issues_assignees (
    issue_id bigint NOT NULL,
    assignee_id bigint NOT NULL
);


ALTER TABLE gha_issues_assignees OWNER TO gha_admin;

--
-- Name: gha_issues_labels; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_issues_labels (
    issue_id bigint NOT NULL,
    label_id bigint NOT NULL
);


ALTER TABLE gha_issues_labels OWNER TO gha_admin;

--
-- Name: gha_labels; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_labels (
    id bigint NOT NULL,
    name character varying(80) NOT NULL,
    color character varying(8) NOT NULL,
    is_default boolean NOT NULL
);


ALTER TABLE gha_labels OWNER TO gha_admin;

--
-- Name: gha_milestones; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_milestones (
    id bigint NOT NULL,
    closed_at timestamp without time zone,
    closed_issues integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    creator_id bigint NOT NULL,
    description text,
    due_on timestamp without time zone,
    number integer NOT NULL,
    open_issues integer NOT NULL,
    state character varying(20) NOT NULL,
    title character varying(120) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE gha_milestones OWNER TO gha_admin;

--
-- Name: gha_orgs; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_orgs (
    id bigint NOT NULL,
    login character varying(80) NOT NULL
);


ALTER TABLE gha_orgs OWNER TO gha_admin;

--
-- Name: gha_pages; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_pages (
    sha character varying(40) NOT NULL,
    action character varying(20) NOT NULL,
    title character varying(160) NOT NULL
);


ALTER TABLE gha_pages OWNER TO gha_admin;

--
-- Name: gha_payloads; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_payloads (
    id bigint NOT NULL,
    push_id integer,
    size integer,
    ref character varying(160),
    head character varying(40),
    before character varying(40),
    action character varying(20),
    issue_id bigint,
    comment_id bigint,
    ref_type character varying(20),
    master_branch character varying(160),
    description text,
    number integer,
    forkee_id bigint,
    release_id bigint,
    member_id bigint
);


ALTER TABLE gha_payloads OWNER TO gha_admin;

--
-- Name: gha_payloads_commits; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_payloads_commits (
    payload_id bigint NOT NULL,
    sha character varying(40) NOT NULL
);


ALTER TABLE gha_payloads_commits OWNER TO gha_admin;

--
-- Name: gha_payloads_pages; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_payloads_pages (
    payload_id bigint NOT NULL,
    sha character varying(40) NOT NULL
);


ALTER TABLE gha_payloads_pages OWNER TO gha_admin;

--
-- Name: gha_releases; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_releases (
    id bigint NOT NULL,
    tag_name character varying(120) NOT NULL,
    target_commitish character varying(160) NOT NULL,
    name character varying(120),
    draft boolean NOT NULL,
    author_id bigint NOT NULL,
    prerelease boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    published_at timestamp without time zone NOT NULL,
    body text
);


ALTER TABLE gha_releases OWNER TO gha_admin;

--
-- Name: gha_releases_assets; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_releases_assets (
    release_id bigint NOT NULL,
    asset_id bigint NOT NULL
);


ALTER TABLE gha_releases_assets OWNER TO gha_admin;

--
-- Name: gha_repos; Type: TABLE; Schema: public; Owner: gha_admin
--

CREATE TABLE gha_repos (
    id bigint NOT NULL,
    name character varying(160) NOT NULL
);


ALTER TABLE gha_repos OWNER TO gha_admin;

--
-- Data for Name: gha_actors; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_actors (id, login) FROM stdin;
\.


--
-- Data for Name: gha_assets; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_assets (id, name, label, uploader_id, content_type, state, size, download_count, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: gha_comments; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_comments (id, body, created_at, updated_at, type, user_id, commit_id, original_commit_id, diff_hunk, "position", original_position, path, pull_request_review_id, line) FROM stdin;
\.


--
-- Data for Name: gha_commits; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_commits (sha, author_name, message, is_distinct) FROM stdin;
\.


--
-- Data for Name: gha_events; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_events (id, type, actor_id, repo_id, payload_id, public, created_at, org_id) FROM stdin;
\.


--
-- Data for Name: gha_forkees; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_forkees (id, name, full_name, owner_id, description, fork, created_at, updated_at, pushed_at, homepage, size, stargazers_count, has_issues, has_projects, has_downloads, has_wiki, has_pages, forks, open_issues, watchers, default_branch, public) FROM stdin;
\.


--
-- Data for Name: gha_issues; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_issues (id, assignee_id, body, closed_at, comments, created_at, locked, milestone_id, number, state, title, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: gha_issues_assignees; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_issues_assignees (issue_id, assignee_id) FROM stdin;
\.


--
-- Data for Name: gha_issues_labels; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_issues_labels (issue_id, label_id) FROM stdin;
\.


--
-- Data for Name: gha_labels; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_labels (id, name, color, is_default) FROM stdin;
\.


--
-- Data for Name: gha_milestones; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_milestones (id, closed_at, closed_issues, created_at, creator_id, description, due_on, number, open_issues, state, title, updated_at) FROM stdin;
\.


--
-- Data for Name: gha_orgs; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_orgs (id, login) FROM stdin;
\.


--
-- Data for Name: gha_pages; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_pages (sha, action, title) FROM stdin;
\.


--
-- Data for Name: gha_payloads; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_payloads (id, push_id, size, ref, head, before, action, issue_id, comment_id, ref_type, master_branch, description, number, forkee_id, release_id, member_id) FROM stdin;
\.


--
-- Data for Name: gha_payloads_commits; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_payloads_commits (payload_id, sha) FROM stdin;
\.


--
-- Data for Name: gha_payloads_pages; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_payloads_pages (payload_id, sha) FROM stdin;
\.


--
-- Data for Name: gha_releases; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_releases (id, tag_name, target_commitish, name, draft, author_id, prerelease, created_at, published_at, body) FROM stdin;
\.


--
-- Data for Name: gha_releases_assets; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_releases_assets (release_id, asset_id) FROM stdin;
\.


--
-- Data for Name: gha_repos; Type: TABLE DATA; Schema: public; Owner: gha_admin
--

COPY gha_repos (id, name) FROM stdin;
\.


--
-- Name: gha_actors gha_actors_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_actors
    ADD CONSTRAINT gha_actors_pkey PRIMARY KEY (id);


--
-- Name: gha_assets gha_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_assets
    ADD CONSTRAINT gha_assets_pkey PRIMARY KEY (id);


--
-- Name: gha_comments gha_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_comments
    ADD CONSTRAINT gha_comments_pkey PRIMARY KEY (id);


--
-- Name: gha_commits gha_commits_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_commits
    ADD CONSTRAINT gha_commits_pkey PRIMARY KEY (sha);


--
-- Name: gha_events gha_events_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_events
    ADD CONSTRAINT gha_events_pkey PRIMARY KEY (id);


--
-- Name: gha_forkees gha_forkees_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_forkees
    ADD CONSTRAINT gha_forkees_pkey PRIMARY KEY (id);


--
-- Name: gha_issues_assignees gha_issues_assignees_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_issues_assignees
    ADD CONSTRAINT gha_issues_assignees_pkey PRIMARY KEY (issue_id, assignee_id);


--
-- Name: gha_issues_labels gha_issues_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_issues_labels
    ADD CONSTRAINT gha_issues_labels_pkey PRIMARY KEY (issue_id, label_id);


--
-- Name: gha_issues gha_issues_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_issues
    ADD CONSTRAINT gha_issues_pkey PRIMARY KEY (id);


--
-- Name: gha_labels gha_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_labels
    ADD CONSTRAINT gha_labels_pkey PRIMARY KEY (id);


--
-- Name: gha_milestones gha_milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_milestones
    ADD CONSTRAINT gha_milestones_pkey PRIMARY KEY (id);


--
-- Name: gha_orgs gha_orgs_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_orgs
    ADD CONSTRAINT gha_orgs_pkey PRIMARY KEY (id);


--
-- Name: gha_pages gha_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_pages
    ADD CONSTRAINT gha_pages_pkey PRIMARY KEY (sha);


--
-- Name: gha_payloads_commits gha_payloads_commits_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_payloads_commits
    ADD CONSTRAINT gha_payloads_commits_pkey PRIMARY KEY (payload_id, sha);


--
-- Name: gha_payloads_pages gha_payloads_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_payloads_pages
    ADD CONSTRAINT gha_payloads_pages_pkey PRIMARY KEY (payload_id, sha);


--
-- Name: gha_payloads gha_payloads_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_payloads
    ADD CONSTRAINT gha_payloads_pkey PRIMARY KEY (id);


--
-- Name: gha_releases_assets gha_releases_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_releases_assets
    ADD CONSTRAINT gha_releases_assets_pkey PRIMARY KEY (release_id, asset_id);


--
-- Name: gha_releases gha_releases_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_releases
    ADD CONSTRAINT gha_releases_pkey PRIMARY KEY (id);


--
-- Name: gha_repos gha_repos_pkey; Type: CONSTRAINT; Schema: public; Owner: gha_admin
--

ALTER TABLE ONLY gha_repos
    ADD CONSTRAINT gha_repos_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

