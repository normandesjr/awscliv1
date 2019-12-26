FROM python:3.8.0-alpine3.10

RUN apk add bash

COPY src/create-resources.sh /root/.local/bin/

ADD .aws /root/.aws

ENV PATH="/root/.local/bin:${PATH}"

RUN pip3 install awscli --upgrade --user

CMD [ "aws", "--version" ]