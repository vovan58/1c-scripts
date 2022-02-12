#!/bin/bash
# $1 - db_name

#################################################
# Created by gvk-it.ru
# Author: Vladimir Glumov
# Date: 18.06.2017 19:33
#################################################

# {{{ config
pg_host="localhost"
pg_user="postgres"
pg_pass="password"
pg_dbname=$1

dir_backup="/var/backup/"

date_file=`date +%Y-%m-%d`

days_keep_backup=30
# }}}

## {{{ remove old backups
#find ${dir_backup} -maxdepth 1 -name ${pg_dbname}*.sql.gz -ctime +${days_keep_backup} -exec rm -rf {} \; >/dev/null 2>&1
## }}}

# {{{ create folder backup
if ! [ -d ${dir_backup}/ ]; then
    mkdir -p ${dir_backup}/
    chmod 700 ${dir_backup}/
fi
# }}}

# {{{ postgres dump
	pg_dump -U $pg_user $pg_dbname | gzip > ${dir_backup}/{$pg_dbname}_${date_file}.sql.gz
# }}}


## {{{ mysql dump
#if ! [ -d ${dir_backup}${date_folder}/mysql/ ]; then
#    mkdir ${dir_backup}${date_folder}/mysql/
#fi

#for db_name in `mysql -u${mysql_user} -p${mysql_pass} -h${mysql_host} -e "show databases;" | tr -d "| " | grep -Ev "(Database|information_schema|performance_schema)"`
#do
#    if [[ ${db_name} != "information_schema" ]] && [[ ${db_name} != _* ]] ; then
#        echo "Dumping database: ${db_name}"
#        mysqldump -u${mysql_user} -p${mysql_pass} -h${mysql_host} --events ${db_name} > ${dir_backup}${date_folder}/mysql/${db_name}.sql
#    fi
#done
# }}}



## {{{ files sites backup
#if ! [ -d ${dir_backup}${date_folder}/home/ ]; then
#    mkdir ${dir_backup}${date_folder}/home/
#fi

#cd ${dir_sites}

#for site_folder in `ls ${dir_sites} | grep -Ev "*.(html|php)"`
#do
#    echo "Dumping site: ${site_folder}"
#    tar cpfP ${dir_backup}${date_folder}/home/${site_folder}.tar ${site_folder}/ --exclude "logs" "bitrix/updates" --exclude "bitrix/backup" --exclude "bitrix/cache" --exclude "bitrix/managed_cache" --exclude "bitrix/stack_cache" --exclude "bitrix/html_pages" --exclude "upload/tmp" --exclude "upload/resize_cache"
#done
# }}}

## {{{ etc folder backup
#if ! [ -d ${dir_backup}${date_folder}/etc/ ]; then
#    mkdir ${dir_backup}${date_folder}/etc/
#fi

#echo "Dumping /etc/"
#tar cpfP ${dir_backup}${date_folder}/etc/etc.tar /etc/
## }}}