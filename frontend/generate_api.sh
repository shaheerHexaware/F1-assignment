#!/bin/bash

if ! command -v openapi-generator &> /dev/null; then
    brew install openapi-generator
fi

openapi-generator generate -i ./packages/f1_api_client/openapi.json -g dart -o ./packages/f1_api_client --skip-validate-spec --additional-properties=pubName=f1_api_client --model-name-suffix=DTO