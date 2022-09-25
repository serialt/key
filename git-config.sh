#!/usr/bin/env bash
# ******************************************************
# Author       	:	serialt
# Email        	:	t@imau.cc
# Filename     	:	git-config.sh
# Version      	:	v1.0
# Created Time 	:	2022-05-15 05:47
# Last modified	:	2022-09-25 11:25
# By Modified  	:
# Description  	:       配置git环境
#       cat git-config.sh  | bash -s -- imau imau.cc
# ******************************************************

InitGit() {

    USER_NAME=$1
    USER_MAIL=$2
    IS_FORCE=true

    if [[ -f ~/.gitconfig ]] ; then
        read -p "git config 已经存在，请确定是否覆盖[y/n]: " GIT_CONFIG
        if [[ ${GIT_CONFIG} == 'y' ]] || [[ ${GIT_CONFIG} == 'yes' ]] || [[ ${GIT_CONFIG} == 'Y' ]] || [[ ${GIT_CONFIG} == 'YES' ]] ; then
        IS_FORCE=true

        fi 
    else 
        IS_FORCE=true
    fi 
    
    if ${IS_FORCE}; then
        cat >~/.gitconfig <<EOF
[user]
        name = ${USER_NAME}
        email = ${USER_MAIL}
#       signingkey = xxxxxxxxxxxxxxxxxxxxxx
#[commit]
#        gpgsign = true
[color]
        ui = true
[alias]
        lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
[alias]
        # status
        st  = status
        ss = status --short --branch

        # stash
        sh  = stash
        shp = stash pop
        shl = stash list
        shs = stash save
        sha = stash apply
        std = stash drop

        # branch
        br  = branch
        bra = branch -a
        brm = branch -m
        co  = checkout
        cob = checkout -b
        sw  = switch
        swc = switch -c
        
        # remote
        ra  = remote add
        rao = remote add origin
        ru  = remote set-url
        ruo = remote set-url origin
        rv = remote -v

        # fetch
        fe  = fetch
        fep = fetch -p
        fo  = fetch origin
        fop = fetch origin -p

        # merge
        mr  = merge
        mnc = merge --no-commit
        # msq = merge --squash

        # commit
        cm = commit -m


[url "git@github.com:"]
        insteadOf = https://github.com/${USER_NAME}

[core]
        excludesfile = ~/.gitignore_global
        autocrlf = input
        quotepath = false
        ignorecase = false
#       sshCommand = ssh -i ~/.ssh/id_rsa -o IdentitiesOnly=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

[i18n "commit"]
        encoding = utf-8
[i18n]
        logoutputencoding = utf-8
    
EOF
    fi
    
}


InitGit
