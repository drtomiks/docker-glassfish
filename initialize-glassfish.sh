#!/bin/bash

domains_dir=/opt/glassfish4/glassfish/domains

if [ ! "$(ls -A ${domains_dir})" ]; then
    echo "${domains_dir} is empty, create test domain"
    asadmin create-domain --nopassword test
fi


