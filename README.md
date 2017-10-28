# aws-lambda-by-hand

This shows how easy it is to create and invoke AWS Lambda functions without a framework. Read the [Makefile](Makefile) for all the magic.

Following on from the tutorial at: http://docs.aws.amazon.com/lambda/latest/dg/with-userapp-walkthrough-custom-events-create-nodejs-function.html

You'll have to manually create the role, and from there, you can just run `make create` followed by `make invoke`. Make changes to lambda.js and then run `make update` to re-deploy.

Run `make delete` to clean up.
