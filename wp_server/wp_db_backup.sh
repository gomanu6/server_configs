#!/bin/bash

. ./webserver_settings.config

## DB backups

cd "${wp_db_backup_dir}"

mysqldump --add-drop-table -h localhost -u "${mysql_username}" -p "${mysql_db_name}" | gzip > ${mysql_db_name}.bak.$(date +%Y%m%d).sql



