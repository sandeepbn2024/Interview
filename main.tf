terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40"
    }
  }

  required_version = ">= 1.2.0"
}

  backend "s3" {
    bucket                  = "STATE-BUCKET-NAME"
    dynamodb_table          = "DYNAMODB-TABLE-NAME"
    key                     = "my-terraform-project"
    region                  = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
  }
}
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "${var.prefix}iam_role_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "src/hello.rb"
  output_path = "hello_payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "hello_payload.zip"
  function_name = "${var.prefix}iam_lambda_function"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "hello.handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "ruby3.2"

  environment {
    variables = {
      developer = var.developer_name
      email = var.developer_email
    }
  }
}
