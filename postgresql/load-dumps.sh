#!/bin/bash
set -e

base_dir=$(readlink -f $(dirname $0))
dump_dir=${base_dir}/dumps.d

if [ ! -d ${dump_dir} ]; then
    echo "${dump_dir} does not exist."
    exit 0
fi

for dump_file in $(ls -1 ${dump_dir}/*.sql 2>/dev/null); do
    echo "Loading dump '${dump_file}'..."
    psql -v ON_ERROR_STOP=1 -U ${POSTGRES_USER} -d ${POSTGRES_DB} < ${dump_file}
done

exit 0
