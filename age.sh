#!/usr/bin/env bash
# ******************************************************
# Author        :       serialt
# Email         :       t@imau.cc
# Filename      :       age.sh
# Version       :       v1.0
# Created Time  :       2022-10-01 15:47
# Last modified :       2022-10-03 11:32
# By Modified   :
# Description   :     age 加密
#
# ******************************************************


AGE_VERSION="1.0.0"
# https://gitee.com/serialt/key/releases/download/v1.0.0/age-v1.0.0-linux-amd64.tar.gz
AGE_PKG_URL="https://gitee.com/serialt/key/releases/download"
AGE_PUBLIC_KEY_URL="https://gitee.com/serialt/key/raw/main/sugar.pub"
AGE_KEY_DIR="$HOME/.sugar"
OS_ARCH=`arch`
OS_SYSTEM=`uname | tr "[A-Z]" "[a-z]"`

[[ ${OS_ARCH} == 'x86_64' ]] && OS_ARCH="amd64"


CheckKey(){
    [[ ! -d ${AGE_KEY_DIR} ]] && mkdir -p ${AGE_KEY_DIR}
    [[ ! -f ${AGE_KEY_DIR}/sugar.pub  ]] && curl -fsSL ${AGE_PUBLIC_KEY_URL} > ${AGE_KEY_DIR}/sugar.pub
    if [[ ! -d ${AGE_KEY_DIR}/age ]] ;then
        curl -fsSL ${AGE_PKG_URL}/v${AGE_VERSION}/age-v${AGE_VERSION}-${OS_SYSTEM}-${OS_ARCH}.tar.gz > ${AGE_KEY_DIR}/age-v${AGE_VERSION}-${OS_SYSTEM}-${OS_ARCH}.tar.gz
        tar -xf ${AGE_KEY_DIR}/age-v${AGE_VERSION}-${OS_SYSTEM}-${OS_ARCH}.tar.gz -C ${AGE_KEY_DIR}/      
    fi
    
}




EncryptFile(){
    input_file=$1
    output_file=$2
    [[ ! -f ${input_file} ]] && echo -en "  Encrypt file failed: ${input_file} is not a file." && break
    ${AGE_KEY_DIR}/age/age -R ${AGE_KEY_DIR}/sugar.pub ${input_file} > ${output_file}
    echo -en "Encrypt file succeed:\n    input file: ${input_file}\n    output file: ${output_file}\n"
}

DecryptFile(){
    private_key=$1
    input_file=$2
    output_file=$3

    [[ ! -f ${input_file} ]] && echo -en "  Decrypt file failed: ${input_file} is not a file." && break
    [[ ! -f ${private_key} ]] && echo -en "  Decrypt file failed: ${private_key} is not a file." && break
    ${AGE_KEY_DIR}/age/age -d  -i ${private_key} ${input_file} > ${output_file}
    echo -en "Decrypt file succeed:\n    input file: ${input_file}\n    output file: ${output_file}]\n"
}

#### main
CheckKey
[[ $1 == '-d' ]] && DecryptFile $2 $3 $4
[[ $1 == '-e' ]] && EncryptFile $2 $3
