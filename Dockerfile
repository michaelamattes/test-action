###################################### Image ######################################
ARG TESTS_DIR=tests

## build Image
FROM golang:latest
SHELL ["/bin/bash", "-c"]

COPY ${TESTS_DIR}/ /${TESTS_DIR}/


ARG REPOSITORIES_MICROSOFT_GPG='https://packages.microsoft.com/keys/microsoft.asc'
ARG REPOSITORIES_MICROSOFT_URI=''
ARG REPOSITORIES_MICROSOFT_BRANCH='main'

RUN apt-get update && apt-get install -y software-properties-common

## repositories
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee "/etc/apt/trusted.gpg.d/MICROSOFT.gpg" > /dev/null && apt-add-repository "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" && \
    curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | bash

RUN apt-get update && \
    apt-get install -y terraform azure-cli


# ###################################### Test Case ######################################
# ARG WORKDIR=/testcase/tests
# ARG INPUT_DEBUG='true'
# ARG INPUT_TOOL='terratest'
# ARG INPUT_TEST='azure'

# WORKDIR ${WORKDIR}

# RUN declare -l DEBUG="${INPUT_DEBUG}" TOOL="${INPUT_TOOL}" TEST="${INPUT_TEST}" && \
#     if [ "${DEBUG}" = "true" ] ; then DEBUG_MODE='-v'; else DEBUG_MODE=''; fi && \
#     go test ${DEBUG_MODE} ${WORKDIR}/${TOOL}/${TEST}_test.go
