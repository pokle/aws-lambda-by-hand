
LAMBDA             := helloworld
AWS_REGION         := ap-southeast-2
AWS_LAMBDA_RUNTIME := nodejs6.10
AWS_LAMBDA_ROLE    := arn:aws:iam::158527237998:role/helloworld-lambda-role
DIST               := dist/$(LAMBDA).zip

$(DIST): *.js
	@mkdir -p dist
	@rm -f $(DIST)
	@zip -o $@ lambda.js

create: $(DIST)
	@aws lambda create-function \
		--region $(AWS_REGION) \
		--function-name $(LAMBDA) \
		--zip-file fileb://$(DIST) \
		--role $(AWS_LAMBDA_ROLE) \
		--handler lambda.handler \
		--runtime $(AWS_LAMBDA_RUNTIME) \
		--publish

update: $(DIST)
	@aws lambda update-function-code \
		--region $(AWS_REGION) \
		--function-name $(LAMBDA) \
		--zip-file fileb://$(DIST) \
		--publish		

delete:
	@aws lambda delete-function \
		--region $(AWS_REGION) \
		--function-name $(LAMBDA)

invoke:
	@aws lambda invoke \
		--invocation-type RequestResponse \
		--function-name $(LAMBDA) \
		--region $(AWS_REGION) \
		--log-type Tail \
		--payload '{"key1":"value1", "key2":"value2", "key3":"value3"}' \
		invoke-output.txt > invoke-result.json
	@jq -r '.LogResult' invoke-result.json | base64 -D

.PHONY: create update delete invoke