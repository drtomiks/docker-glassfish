#!/bin/bash

SCRIPT=$(readlink -f "$0")
bin_dir=$(dirname "$SCRIPT")
root_dir=${bin_dir}/..
domains_dir=/opt/glassfish4/glassfish/domains

export bin_dir root_dir domains_dir

set -e

if [ ! -f ${root_dir}/.glassfish-initialized ]; then
  ${bin_dir}/initialize-glassfish.sh
  touch ${root_dir}/.glassfish-initialized
fi

if [ ! -f ${root_dir}/.glassfish-initialized ] || [ ! -f ${root_dir}/.glassfish_admin_password_changed ]; then
    echo "=> Start Glassfish server"
    asadmin start-domain 

    if [ ! -f ${root_dir}/.glassfish_configured ]; then
       ${bin_dir}/configure-glassfish.sh
       touch ${root_dir}/.glassfish-configured
    fi

    if [ ! -f ${root_dir}/.glassfish_admin_password_changed ]; then
        echo "Set admin password"
        ${bin_dir}/change_admin_password.sh

    fi

    echo "=> Stop Glassfish server"
    asadmin stop-domain
fi

deploy_dir=${root_dir}/deploy
if [ "$(ls -A ${deploy_dir})" ]; then
    echo "${deploy_dir} is not empty, copy deploy files to ${domains_dir}/autodeploy"
    cp ${deploy_dir}/* ${domains_dir}/autodeploy
fi


echo "=> Starting and running Glassfish server"
DEBUG_MODE=${DEBUG:-false}
echo "=> Debug mode is set to: ${DEBUG_MODE}"
exec asadmin start-domain --debug=${DEBUG_MODE} --watchdog
