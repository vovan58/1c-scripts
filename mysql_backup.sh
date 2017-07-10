#!/bin/bash

#################################################
# Created by olegpro.ru
# Author: Oleg Maksimenko
# Date: 04.01.2015 19:33
#################################################

# {{{ config
mysql_host="localhost"
mysql_user="root"
mysql_pass="password"

dir_backup="/backup/daily/"
dir_sites="/var/www/"

date_folder=`date +%Y-%m-%d`

days_keep_backup=5
# }}}

# {{{ remove old backups
find ${dir_backup} -maxdepth 1 -ctime +$[${days_keep_backup}-1] -exec rm -rf {} \; >/dev/null 2>&1
# }}}

# {{{ create folder backup
if ! [ -d ${dir_backup}${date_folder}/ ]; then
    mkdir -p ${dir_backup}${date_folder}/
    chmod 700 ${dir_backup}${date_folder}/
fi
# }}}

# {{{ mysql dump
if ! [ -d ${dir_backup}${date_folder}/mysql/ ]; then
    mkdir ${dir_backup}${date_folder}/mysql/
fi

for db_name in `mysql -u${mysql_user} -p${mysql_pass} -h${mysql_host} -e "show databases;" | tr -d "| " | grep -Ev "(Database|information_schema|performance_schema)"`
do
    if [[ ${db_name} != "information_schema" ]] && [[ ${db_name} != _* ]] ; then
        echo "Dumping database: ${db_name}"
        mysqldump -u${mysql_user} -p${mysql_pass} -h${mysql_host} --events ${db_name} > ${dir_backup}${date_folder}/mysql/${db_name}.sql
    fi
done
# }}}

# {{{ files sites backup
if ! [ -d ${dir_backup}${date_folder}/home/ ]; then
    mkdir ${dir_backup}${date_folder}/home/
fi

cd ${dir_sites}

for site_folder in `ls ${dir_sites} | grep -Ev "*.(html|php)"`
do
    echo "Dumping site: ${site_folder}"
    tar cpfP ${dir_backup}${date_folder}/home/${site_folder}.tar ${site_folder}/ --exclude "logs" "bitrix/updates" --exclude "bitrix/backup" --exclude "bitrix/cache" --exclude "bitrix/managed_cache" --exclude "bitrix/stack_cache" --exclude "bitrix/html_pages" --exclude "upload/tmp" --exclude "upload/resize_cache"
done
# }}}

# {{{ etc folder backup
if ! [ -d ${dir_backup}${date_folder}/etc/ ]; then
    mkdir ${dir_backup}${date_folder}/etc/
fi

echo "Dumping /etc/"
tar cpfP ${dir_backup}${date_folder}/etc/etc.tar /etc/
# }}}