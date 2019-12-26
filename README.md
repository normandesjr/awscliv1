# Docker AWSCLI V1

The main goal of this project is to run AWS CLI dynamodb commands with docker-compose.yml to support testing local.

## Building this image
````
docker build -t normandesjr/awscliv1:latest .
````

## Running multiple files

There is a pattern to follow in order to run the create-table and batch-write-item correctly and in right sequence.

The pattern for the filename is: <number>-<command>-<name>.json

The *number* will be used to create the order.

The *command* are:

* ct stands for _create-table_
* bwi stands for _batch-write-item_

And the *name* is some arbritary name.

## AWS Credentials

The AWS credentials you have to use for local tests are: "local" and "local" for access and secret access key.

## Example

Take a look at example folder to see the docker-compose.yml and json files.
