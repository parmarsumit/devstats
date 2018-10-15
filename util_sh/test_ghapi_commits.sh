#!/bin/bash
if [ -z "${PG_PASS}" ]
then
  echo "$0: you need to specify PG_PASS=... $0 $*"
  exit 1
fi
# FROM="2018-10-15" REPO="cncf/devstats" GHA2DB_QOUT=1 GHA2DB_DEBUG=1 GHA2DB_GHAPISKIPEVENTS=1 PG_DB=cncf ./ghapi2db
# REPO="cncf/devstats" GHA2DB_DEBUG=1 GHA2DB_GHAPISKIPEVENTS=1 GHA2DB_QOUT=1 PG_DB=cncf ./ghapi2db
# FROM="2018-10-01" REPO="cncf/landscape" GHA2DB_GHAPISKIPEVENTS=1 PG_DB=cncf ./ghapi2db
# FROM="2018-10-01" GHA2DB_GHAPISKIPEVENTS=1 PG_DB=cncf ./ghapi2db
# FROM="2018-06-01" GHA2DB_GHAPISKIPEVENTS=1 PG_DB=cncf ./ghapi2db
# FROM="2018-06-01" REPO="cncf/k8s-conformance" GHA2DB_GHAPISKIPEVENTS=1 PG_DB=cncf ./ghapi2db
# REPO="cncf/k8s-conformance" GHA2DB_GHAPISKIPEVENTS=1 PG_DB=cncf ./ghapi2db
# REPO="cncf/landscape" GHA2DB_GHAPISKIPEVENTS=1 PG_DB=cncf ./ghapi2db
# REPO="cncf/devstats" GHA2DB_GHAPISKIPEVENTS=1 PG_DB=cncf ./ghapi2db
GHA2DB_GHAPISKIPEVENTS=1 GHA2DB_RECENT_REPOS_RANGE="2 years" PG_DB=cncf ./ghapi2db
# REPO="cncf/multi-cloud-provisioner" GHA2DB_RECENT_REPOS_RANGE="2 years" GHA2DB_GHAPISKIPEVENTS=1 PG_DB=cncf ./ghapi2db
# PG_DB=cncf ./ghapi2db
# GHA2DB_NO_AUTOFETCHCOMMITS=1 GHA2DB_RECENT_REPOS_RANGE="3 days" GHA2DB_RECENT_RANGE="3 days" REPO="cncf/landscape" GHA2DB_GHAPISKIPEVENTS=1 PG_DB=cncf ./ghapi2db
