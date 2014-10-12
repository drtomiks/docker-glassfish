#!/bin/bash

set -e

asadmin start-domain 
if [ ! -f /.glassfish_admin_password_changed ]; then
    /change_admin_password.sh
fi
echo "=> Restarting Glassfish server"
asadmin stop-domain
echo "=> Starting and running Glassfish server"
DEBUG_MODE=${DEBUG:"false"}
asadmin start-domain --debug=${DEBUG_MODE} -w
