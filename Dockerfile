#https://www.philschmid.de/create-custom-github-action-in-4-steps

FROM golang:latest
ARG TOOL=${INPUT_TOOL}
ARG TESTNAME=${INPUT_TESTNAME}

COPY tests/* /tests/

RUN ls --recursive /tests/
RUN go test -run -v tests/terratest/test_azure.go
