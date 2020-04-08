#!/bin/bash

bindings_dir=$(dirname $(readlink -f "$0"))

docker run --rm \
  --name postgres \
  -e POSTGRES_PASSWORD='galaxy' \
  -e POSTGRES_USER='galaxy' \
  -p 5432:5432 \
  -d postgres

docker run --rm -u "$(id -u)" -v "${bindings_dir}:/local" \
  openapitools/openapi-generator-cli generate \
  -i /local/openapi.yaml \
  -g python \
  -o /local/galaxy-pulp \
  --skip-validate-spec \
  --additional-properties=packageName=galaxy_pulp,projectName=galaxy-pulp
