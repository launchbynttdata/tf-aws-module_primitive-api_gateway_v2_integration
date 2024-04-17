// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "aws_apigatewayv2_integration" "integration" {
  api_id           = var.api_id
  integration_type = var.integration_type # "AWS_PROXY"

  connection_id                 = var.connection_id
  connection_type               = var.connection_type #"INTERNET"
  content_handling_strategy     = var.content_handling_strategy
  description                   = var.description        # "Lambda function"
  integration_method            = var.integration_method # "POST"
  integration_subtype           = var.integration_subtype
  integration_uri               = var.integration_uri        # module.lambda_function.lambda_function_invoke_arn
  payload_format_version        = var.payload_format_version # "2.0"
  passthrough_behavior          = var.passthrough_behavior
  request_parameters            = var.request_parameters
  request_templates             = var.request_templates
  template_selection_expression = var.template_selection_expression
  timeout_milliseconds          = var.timeout_milliseconds

  dynamic "response_parameters" {
    for_each = var.response_parameters

    content {
      status_code = each.status_code
      mappings    = each.mappings
    }
  }

  dynamic "tls_config" {
    for_each = var.server_name_to_verify != null ? [1] : []

    content {
      server_name_to_verify = var.server_name_to_verify
    }

  }
}
