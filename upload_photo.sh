#!/bin/bash

base64 -i ./photo/cat.jpeg > data.b64

API_KEY="$(aws apigateway get-api-keys \
     --include-value --region eu-west-1  \
     --query "items[?name=='upload-api-key'].value" \
     --output text)"


cat > payload.json <<EOF
{"filename":"cat.jpeg","data":"$(< data.b64)"}
EOF

curl -v -X POST \
     -H "Content-Type: application/json" \
     -H "x-api-key: ${API_KEY}" \
     --data-binary @payload.json \
     "$(terraform output -raw api_endpoint)"

rm payload.json
rm data.b64