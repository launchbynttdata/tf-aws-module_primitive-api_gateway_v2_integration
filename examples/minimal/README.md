# minimal

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.14 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | terraform.registry.launch.nttdata.com/module_primitive/api_gateway_v2/aws | ~> 1.0 |
| <a name="module_api_gateway_integration"></a> [api\_gateway\_integration](#module\_api\_gateway\_integration) | terraform.registry.launch.nttdata.com/module_primitive/api_gateway_v2_integration/aws | ~> 1.0 |
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>    region     = optional(string, "eastus2")<br>  }))</pre> | <pre>{<br>  "api_gateway": {<br>    "max_length": 80,<br>    "name": "apigw",<br>    "region": "us-east-2"<br>  }<br>}</pre> | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"apigw"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"demo"` | no |
| <a name="input_integration_type"></a> [integration\_type](#input\_integration\_type) | Integration type of an integration. Valid values: `AWS` (supported only for WebSocket APIs), `AWS_PROXY`, `HTTP` (supported only for WebSocket APIs), `HTTP_PROXY`, `MOCK` (supported only for WebSocket APIs). For an HTTP API private integration, use `HTTP_PROXY`. | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Type of the network connection to the integration endpoint. Valid values: `INTERNET`, `VPC_LINK`. Default is `INTERNET` | `string` | `"INTERNET"` | no |
| <a name="input_description"></a> [description](#input\_description) | Integration Description | `string` | `null` | no |
| <a name="input_integration_method"></a> [integration\_method](#input\_integration\_method) | Integration's HTTP method, e.g. `GET` or `POST`. Must be supplied if `integration_type` is not `MOCK`. | `string` | `null` | no |
| <a name="input_integration_uri"></a> [integration\_uri](#input\_integration\_uri) | Optional URI of the Lambda function for a Lambda proxy integration, when `integration_type` is `AWS_PROXY`. For an `HTTP` integration, specify a fully-qualified URL. For an HTTP API private integration, specify the ARN of an Application Load Balancer listener, Network Load Balancer listener, or AWS Cloud Map service. | `string` | `null` | no |
| <a name="input_payload_format_version"></a> [payload\_format\_version](#input\_payload\_format\_version) | The format of the payload sent to an integration. Version-specific details can be found at https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#http-api-develop-integrations-lambda.proxy-format. Valid values: `1.0`, `2.0`. Default is `2.0`. | `string` | `"2.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_id"></a> [api\_gateway\_id](#output\_api\_gateway\_id) | n/a |
| <a name="output_api_protocol_type"></a> [api\_protocol\_type](#output\_api\_protocol\_type) | n/a |
| <a name="output_api_gateway_integration_id"></a> [api\_gateway\_integration\_id](#output\_api\_gateway\_integration\_id) | n/a |
| <a name="output_api_gateway_integration_response_selection_expression"></a> [api\_gateway\_integration\_response\_selection\_expression](#output\_api\_gateway\_integration\_response\_selection\_expression) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
