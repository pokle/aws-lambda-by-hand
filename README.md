# aws-lambda-by-hand

This shows how easy it is to create and invoke AWS Lambda functions without a framework. Read the [Makefile](Makefile) for all the magic.

## First time creation

Ensure you have the AWS cli tools, make, and jq installed. Oh, and make sure you aws cli is logged in and has enough admin privileges to create lambdas.

Create the IAM role required for the lambda (in [lambda-role.json](lambda-role.json)). This step writes information about the created role to a file that you should commit to your git: lambda-role-created.json

    make create-role


Create the lambda (in [lambda.js](lambda.js)). This uses the lambda-role-created.json file from the previous step.

    make create

## Invoking the lambda

    $ make invoke
    START RequestId: 8e5feb7b-bba8-11e7-8aa9-01f433c8cdfe Version: $LATEST
    2017-10-28T06:23:47.623Z        8e5feb7b-bba8-11e7-8aa9-01f433c8cdfe    value1 = value1
    2017-10-28T06:23:47.659Z        8e5feb7b-bba8-11e7-8aa9-01f433c8cdfe    value2 = value2
    2017-10-28T06:23:47.659Z        8e5feb7b-bba8-11e7-8aa9-01f433c8cdfe    value3 = value3
    END RequestId: 8e5feb7b-bba8-11e7-8aa9-01f433c8cdfe
    REPORT RequestId: 8e5feb7b-bba8-11e7-8aa9-01f433c8cdfe  Duration: 43.96 ms      Billed Duration: 100 ms         Memory Size: 128 MB     Max Memory Used: 20 MB

## Updates

Edit lambda.js, and then you can re-deploy the lambda and invoke it in one shot:

    make update invoke

## Clean up

Lambda's don't cost anything at rest, but lets clean up anyway:

    make delete
    make delete-role

----
Based on the tutorial at: http://docs.aws.amazon.com/lambda/latest/dg/with-userapp-walkthrough-custom-events-create-nodejs-function.html
