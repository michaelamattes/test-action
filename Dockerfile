#https://www.philschmid.de/create-custom-github-action-in-4-steps

FROM golang:latest

COPY tests/* /tests/

RUN go test -run tests/${INPUT_TOOL}/${INPUT_TESTNAME}
