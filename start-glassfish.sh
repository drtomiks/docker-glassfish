#!/bin/bash

set -e

if [ ! -f /.glassfish-initialized ]; then
  /initialize-glassfish.sh
  touch /.glassfish-initialized
fi

if [ ! -f /.glassfish_admin_password_changed ]; then
    echo "=> Changing password"
    echo "=> Start Glassfish server"
    asadmin start-domain 
    echo "Set admin password"
    /change_admin_password.sh

    if [ ! -f /.glassfish_configured ]; then
       /configure-glassfish.sh
       touch /.glassfish-configured
    fi

    echo "=> Stop Glassfish server"
    asadmin stop-domain
fi

echo "=> Starting and running Glassfish server"
DEBUG_MODE=${DEBUG:-false}
echo "=> Debug mode is set to: ${DEBUG_MODE}"
exec asadmin start-domain --debug=${DEBUG_MODE} --watchdog
