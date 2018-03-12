#!/bin/bash
# IDB=1 (will update InfluxDB)
# GET=1 (will fetch allprj database from backup - not recommended because local merge is faster)
set -o pipefail
if ( [ -z "$1" ] || [ -z "$2" ] )
then
  echo "$0: You need to provide project name and org name as arguments"
  exit 1
fi
if ( [ -z "$PG_PASS" ] || [ -z "$IDB_PASS" ] || [ -z "$IDB_HOST" ] )
then
  echo "$0: You need to set PG_PASS, IDB_PASS, IDB_HOST environment variables to run this script"
  exit 2
fi
exists=`sudo -u postgres psql -tAc "select 1 from pg_database WHERE datname = 'allprj'"` || exit 3
if [ ! "$exists" = "1" ]
then
  echo "All CNCF Project database doesn't exist"
  exit 0
fi
added=`sudo -u postgres psql allprj -tAc "select name from gha_repos where name = '$2'"` || exit 4
if [ "$added" = "$2" ]
then
  echo "Project '$1' is already present in 'All CNCF', org '$2' exists"
  exit 0
fi
function finish {
    sync_unlock.sh
}
if [ -z "$TRAP" ]
then
  sync_lock.sh || exit -1
  trap finish EXIT
  export TRAP=1
fi
if [ ! -z "$GET" ]
then
  echo "attempt to fetch postgres database allprj from backup"
  wget "https://cncftest.io/allprj.dump" || exit 5
  sudo -u postgres pg_restore -d allprj allprj.dump || exit 6
  rm -f allprj.dump || exit 7
  echo "allprj backup restored"
else
  GHA2DB_INPUT_DBS="$1" GHA2DB_OUTPUT_DB="allprj" ./merge_pdbs || exit 8
  PG_DB="allprj" ./devel/remove_db_dups.sh || exit 9
  ./all/get_repos.sh || exit 10
  ./all/setup_repo_groups.sh || exit 11
fi
if [ -z "$IDB" ]
then
  ./all/top_n_repos_groups.sh 70 > out || exit 12
  ./all/top_n_companies 70 >> out || exit 13
  cat out
  echo 'Please update ./metrics/all/gaps*.yaml with new companies & repo groups data (also dont forget repo groups).'
  echo 'Then run ./all/reinit.sh.'
  echo 'Top 70 repo groups & companies are saved in "out" file.'
else
  ./all/reinit.sh || exit 14
fi
echo 'OK'
