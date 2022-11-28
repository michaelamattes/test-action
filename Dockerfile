###################################### Image ######################################
ARG TESTS_DIR=/tests

## build Image
FROM golang:latest
SHELL ["/bin/bash", "-c"]

COPY ${TESTS_DIR}/ /${TESTS_DIR}/

RUN curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | bash && \
    apt-get update && \
    apt-get install -y terraform

###################################### Test Case ######################################
ARG WORKDIR=/tests
ARG INPUT_DEBUG='true'
ARG INPUT_TOOL='terratest'
ARG INPUT_TEST='azure'

WORKDIR ${WORKDIR}

RUN declare -l DEBUG="${INPUT_DEBUG}" TOOL="${INPUT_TOOL}" TEST="${INPUT_TEST}" && \
    if [ "${DEBUG}" = "true" ] ; then DEBUG_MODE='-v'; else DEBUG_MODE=''; fi && \
    go test ${DEBUG_MODE} ${WORKDIR}/${TOOL}/${TEST}_test.go
