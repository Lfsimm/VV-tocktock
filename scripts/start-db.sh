#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
data_dir="$project_dir/.local/mysql"
socket="$project_dir/.local/mysql.sock"

if [[ ! -d "$data_dir" ]]; then
    echo "Banco não inicializado em $data_dir" >&2
    exit 1
fi

if mysqladmin --socket="$socket" -u root ping >/dev/null 2>&1; then
    echo "MySQL do TOCKTOCK já está em execução."
    exit 0
fi

nohup mysqld --no-defaults --datadir="$data_dir" --socket="$socket" \
    --pid-file="$project_dir/.local/mysql.pid" --port=3306 \
    --bind-address=127.0.0.1 >> "$project_dir/.local/mysql.log" 2>&1 < /dev/null &

for _ in {1..30}; do
    if mysqladmin --socket="$socket" -u root ping >/dev/null 2>&1; then
        echo "MySQL do TOCKTOCK iniciado."
        exit 0
    fi
    sleep 1
done

echo "Falha ao iniciar o MySQL. Consulte .local/mysql.log" >&2
exit 1
