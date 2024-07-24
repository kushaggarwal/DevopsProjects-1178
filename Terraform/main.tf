resource "aws_dynamodb_table" "product_table" {
  name = "PRODUCT"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "product_id"

  attribute {
    name = "product_id"
    type = "S"
  }

  attribute {
    name = "category"
    type = "S"
  }
  attribute {
    name = "product_rating"
    type = "N"
  }

  global_secondary_index {
    name = "ProductCategoryRatingIndex"
    hash_key = "category"
    range_key = "product_rating"
    projection_type = "ALL"
  }
}

resource "aws_api_gateway_rest_api" "product_apigw" {
  name = "product_apigw"
  description = "Product API Gateway"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "product" {
  rest_api_id = aws_api_gateway_rest_api.product_apigw.id
  parent_id = aws_api_gateway_rest_api.product_apigw.root_resource_id
  path_part = "product"
}

resource "aws_api_gateway_method" "createproduct" {
    rest_api_id = aws_api_gateway_rest_api.product_apigw.id
    resource_id = aws_api_gateway_resource.product.id
    http_method = "POST"
    authorization = "NONE"
}

resource "aws_iam_role" "ProductLambdaRole" {
  name = "ProductLambdaRole"
  assume_role_policy = <<EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
    }
  ]
  }
  EOF
}