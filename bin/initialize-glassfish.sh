#!/bin/bash

if [ ! "$(ls -A ${domains_dir})" ]; then
    echo "${domains_dir} is empty, create test domain"
    asadmin create-domain --nopassword domain1
fi


