# terraform-aws-lambda

Terraform configuration to create an AWS Lambda function to run the application in [src/hello.rb](src/hello.rb).

Terraform state is saved on local backend.

## Next step
> 1. Implement a Github Actions workflow to apply the changes to terraform configuration. Use AWS S3 backend to ensure that state is shared across the workflow runs. Any changes to terraform configuration should be automatically applied on push to `main` branch only, push to other branches or creation of pull requests should not trigger the workflow.
> 2. Push the updated code to a private Github repository.
> 3. Please configure the repository to allow HabitNu evaluators to configure credentials for Github Actions & evaluate the results.

