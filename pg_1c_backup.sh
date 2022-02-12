#!/bin/sh
# https://www.dmosk.ru/miniinstruktions.php?mini=postgresql-dump

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

#PGPASSWORD=password
#export PGPASSWORD

dir_backup = "~/backup/"
dbUser=postgresql
# имя базы задается первым параметром
database=$1
# срок хранения дней
days_keep_backup=61

# {{{ create folder backup
if ! [ -d ${dir_backup}/ ]; then
    mkdir -p ${dir_backup}/
    chmod 700 ${dir_backup}/
fi
# }}}


find ${dir_backup} \( -name "*-1[^5].*" -o -name "*-[023]?.*" \) -ctime +$[${days_keep_backup}-1] -delete
pg_dump -U $dbUser $database | gzip > ${dir_backup}/{$database}_$(date "+%Y-%m-%d").sql.gz

#unset PGPASSWORD