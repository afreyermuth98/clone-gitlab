#!/bin/sh

usage() {
    echo "Use: clone-gitlab <HOST> <GROUP_ID> <PRIVATE_TOKEN> <TOKEN_NAME>"
    exit 1
}

counter=0

clone() {
    project_ids=$(curl -s --header "PRIVATE-TOKEN: $3" https://$1/api/v4/groups/$2 | jq ".projects[].id")
    # counter=$((${counter} + ${#project_ids[@]}))
    
    for project_id in $(curl -s --header "PRIVATE-TOKEN: $3" https://$1/api/v4/groups/$2 | jq ".projects[].id"); 
    do
        project=$(curl -s --header "PRIVATE-TOKEN: $3" https://$1/api/v4/projects/$project_id)
        project_name=`echo $project | jq ".name" | tr -d '"'`
        project_path=$(echo $project | jq ".name_with_namespace" | tr -d '"' | sed "s/ //g")
        if [ "$5" != "" ];then
            project_path=$(echo $project_path | sed "s/$4\///g")
        fi
        project_url=`echo $project | jq ".http_url_to_repo" | tr -d '"' | sed s/$1/$4:$3@$1/`
        printf "Cloning $counter projects"
        printf "\r"

        git clone --quiet $project_url $project_path 2>&1 | grep -v 'warning'
        ((counter=counter+1))
    done
    groups=$(curl -s --header "PRIVATE-TOKEN: $3" https://$1/api/v4/groups/$2/subgroups | jq ".[].id")
    if [ "$groups" != "" ]; then
        local_group_path=$group_path
        for group in $groups
        do
            clone $1 $group $3 $4
        done
    fi

}

if [[ $# -eq 4 ]]
then
    group_name=$(curl -s --header "PRIVATE-TOKEN: $3" https://$1/api/v4/groups/$2 | jq ".name" | tr -d '"')
    path_to_kill="$(curl -s --header "PRIVATE-TOKEN: $3" https://$1/api/v4/groups/$2 | jq ".full_name" | tr -d '"' | tr -d ' ' | sed s/.$group_name//)"
    if [ $path_to_kill == $group_name ]; then
        path_to_kill=""
    fi
    clone $* $path_to_kill
    echo "Cloned $counter projects !"
else
    usage
fi
