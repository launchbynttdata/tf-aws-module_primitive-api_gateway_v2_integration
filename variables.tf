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

variable "api_id" {
  description = "ID of the API Gateway to which this integration will attach"
  type        = string
}

variable "integration_type" {
  description = "Integration type of an integration. Valid values: `AWS` (supported only for WebSocket APIs), `AWS_PROXY`, `HTTP` (supported only for WebSocket APIs), `HTTP_PROXY`, `MOCK` (supported only for WebSocket APIs). For an HTTP API private integration, use `HTTP_PROXY`."
  type        = string
  validation {
    condition     = contains(["AWS", "AWS_PROXY", "HTTP", "HTTP_PROXY", "MOCK"], var.integration_type)
    error_message = "integration_type must be one of AWS, AWS_PROXY, HTTP, HTTP_PROXY, MOCK"
  }
}

variable "connection_id" {
  description = "Optional ID of the VPC link for a private integration. Supported only for HTTP APIs. Must be between 1 and 1024 characters in length."
  type        = string
  default     = null

  validation {
    condition     = var.connection_id != null ? length(var.connection_id) >= 1 && length(var.connection_id) <= 1024 : true
    error_message = "connection_id must be between 1 and 1024 characters in length!"
  }
}

variable "connection_type" {
  description = "Type of the network connection to the integration endpoint. Valid values: `INTERNET`, `VPC_LINK`. Default is `INTERNET`"
  type        = string
  default     = "INTERNET"
  validation {
    condition     = contains(["INTERNET", "VPC_LINK"], var.connection_type)
    error_message = "connection_type must be one of INTERNET, VPC_LINK"
  }
}

variable "content_handling_strategy" {
  description = "Optional choice for handling response payload content type conversions. Valid values: `CONVERT_TO_BINARY`, `CONVERT_TO_TEXT`. Supported only for WebSocket APIs."
  type        = string
  default     = null

  validation {
    condition     = var.content_handling_strategy != null ? contains(["CONVERT_TO_BINARY", "CONVERT_TO_TEXT"], var.content_handling_strategy) : true
    error_message = "content_handling_strategy must be one of CONVERT_TO_BINARY, CONVERT_TO_TEXT"
  }
}

variable "credentials_arn" {
  description = "Optional Credentials required for the integration."
  type        = string
  default     = null
}

variable "description" {
  description = "Integration Description"
  type        = string
  default     = null
}

variable "integration_method" {
  description = "Integration's HTTP method, e.g. `GET` or `POST`. Must be supplied if `integration_type` is not `MOCK`."
  type        = string
  default     = null
}

variable "integration_subtype" {
  description = "Optional AWS service action to invoke. Supported only for HTTP APIs when integration_type is `AWS_PROXY`. Must be between 1 and 128 characters in length. Supported values can be found at https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-aws-services-reference.html."
  type        = string
  default     = null
}

variable "integration_uri" {
  description = "Optional URI of the Lambda function for a Lambda proxy integration, when `integration_type` is `AWS_PROXY`. For an `HTTP` integration, specify a fully-qualified URL. For an HTTP API private integration, specify the ARN of an Application Load Balancer listener, Network Load Balancer listener, or AWS Cloud Map service."
  type        = string
  default     = null
}

variable "passthrough_behavior" {
  description = "Optional pass-through behavior for incoming requests based on the Content-Type header in the request, and the available mapping templates specified as the request_templates attribute. Valid values: `WHEN_NO_MATCH`, `WHEN_NO_TEMPLATES`, `NEVER`. Default is `WHEN_NO_MATCH`. Supported only for WebSocket APIs."
  type        = string
  default     = "WHEN_NO_MATCH"

  validation {
    condition     = contains(["WHEN_NO_MATCH", "WHEN_NO_TEMPLATES", "NEVER"], var.passthrough_behavior)
    error_message = "passthrough_behavior must be one of WHEN_NO_MATCH, WHEN_NO_TEMPLATES, NEVER"
  }
}

variable "payload_format_version" {
  description = "The format of the payload sent to an integration. Version-specific details can be found at https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#http-api-develop-integrations-lambda.proxy-format. Valid values: `1.0`, `2.0`. Default is `2.0`."
  type        = string
  default     = "2.0"
}

variable "request_parameters" {
  description = "For WebSocket APIs, an optional key-value map specifying request parameters that are passed from the method request to the backend. For HTTP APIs with a specified `integration_subtype`, a key-value map specifying parameters that are passed to `AWS_PROXY` integrations. For HTTP APIs without a specified `integration_subtype`, a key-value map specifying how to transform HTTP requests before sending them to the backend. See the Amazon API Gateway Developer Guide for details: https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-parameter-mapping.html"
  type        = map(string)
  default     = {}
}

variable "request_templates" {
  description = "Optional map of Velocity templates that are applied on the request payload based on the value of the Content-Type header sent by the client. Supported only for WebSocket APIs."
  type        = map(string)
  default     = {}
}

variable "response_parameters" {
  description = "Optional mappings to transform the HTTP response from a backend integration before returning the response to clients. Supported only for HTTP APIs. `status_code` is in the range 200-599. For more info on configuring `mappings`, see https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-parameter-mapping.html."
  type = list(object({
    status_code = number
    mappings    = map(string)
  }))
  default = []
}

variable "template_selection_expression" {
  description = "Optional template selection expression for the integration. See https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-template-selection-expressions for details."
  type        = string
  default     = null
}

variable "timeout_milliseconds" {
  description = "Optional custom timeout between 50 and 29,000 milliseconds for WebSocket APIs and between 50 and 30,000 milliseconds for HTTP APIs. Terraform will only perform drift detection of its value when present in a configuration. The default timeout is 29 seconds for WebSocket APIs and 30 seconds for HTTP APIs."
  type        = number
  default     = null
}

variable "server_name_to_verify" {
  description = "Optional TLS configuration for a private integration. Supported only HTTP APIs. If you specify a server name, API Gateway uses it to verify the hostname on the integration's certificate. The server name is also included in the TLS handshake to support Server Name Indication (SNI) or virtual hosting."
  type        = string
  default     = null
}
