#!/bin/bash

usage() {
    echo "Use: clone-gitlab <HOST> <GROUP_ID> <PRIVATE_TOKEN>"
    exit 1
}

clone() {
    groups=$(curl -s --header "PRIVATE-TOKEN: $3" https://$1/api/v4/groups/$2/subgroups | jq ".[].id")
    if [ "$groups" == "" ]; then
        for project_id in $(curl -s --header "PRIVATE-TOKEN: $3" https://$1/api/v4/groups/$2 | jq ".projects[].id"); 
        do
            project=$(curl -s --header "PRIVATE-TOKEN: $3" https://$1/api/v4/projects/$project_id)
            project_url=`echo $project | jq ".http_url_to_repo" | tr -d '"'`
            project_path=`echo $project | jq ".name_with_namespace" | tr -d '"' | sed 's/ //g'`
            echo "URL PATH $project_url $project_path"
            git clone $project_url $project_path
        done
    else
        for group in $groups
        do
            clone $1 $group $3
        done
    fi  

}

if [[ $# -eq 3 ]]
then
    clone $*
else
    usage
fi
