# tf-aws-module_primitive-api_gateway_v2_integration

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

Provides an API Gateway Integration resource.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.14 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.73.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_apigatewayv2_integration.integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_id"></a> [api\_id](#input\_api\_id) | ID of the API Gateway to which this integration will attach | `string` | n/a | yes |
| <a name="input_integration_type"></a> [integration\_type](#input\_integration\_type) | Integration type of an integration. Valid values: `AWS` (supported only for WebSocket APIs), `AWS_PROXY`, `HTTP` (supported only for WebSocket APIs), `HTTP_PROXY`, `MOCK` (supported only for WebSocket APIs). For an HTTP API private integration, use `HTTP_PROXY`. | `string` | n/a | yes |
| <a name="input_connection_id"></a> [connection\_id](#input\_connection\_id) | Optional ID of the VPC link for a private integration. Supported only for HTTP APIs. Must be between 1 and 1024 characters in length. | `string` | `null` | no |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Type of the network connection to the integration endpoint. Valid values: `INTERNET`, `VPC_LINK`. Default is `INTERNET` | `string` | `"INTERNET"` | no |
| <a name="input_content_handling_strategy"></a> [content\_handling\_strategy](#input\_content\_handling\_strategy) | Optional choice for handling response payload content type conversions. Valid values: `CONVERT_TO_BINARY`, `CONVERT_TO_TEXT`. Supported only for WebSocket APIs. | `string` | `null` | no |
| <a name="input_credentials_arn"></a> [credentials\_arn](#input\_credentials\_arn) | Optional Credentials required for the integration. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Integration Description | `string` | `null` | no |
| <a name="input_integration_method"></a> [integration\_method](#input\_integration\_method) | Integration's HTTP method, e.g. `GET` or `POST`. Must be supplied if `integration_type` is not `MOCK`. | `string` | `null` | no |
| <a name="input_integration_subtype"></a> [integration\_subtype](#input\_integration\_subtype) | Optional AWS service action to invoke. Supported only for HTTP APIs when integration\_type is `AWS_PROXY`. Must be between 1 and 128 characters in length. Supported values can be found at https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-aws-services-reference.html. | `string` | `null` | no |
| <a name="input_integration_uri"></a> [integration\_uri](#input\_integration\_uri) | Optional URI of the Lambda function for a Lambda proxy integration, when `integration_type` is `AWS_PROXY`. For an `HTTP` integration, specify a fully-qualified URL. For an HTTP API private integration, specify the ARN of an Application Load Balancer listener, Network Load Balancer listener, or AWS Cloud Map service. | `string` | `null` | no |
| <a name="input_passthrough_behavior"></a> [passthrough\_behavior](#input\_passthrough\_behavior) | Optional pass-through behavior for incoming requests based on the Content-Type header in the request, and the available mapping templates specified as the request\_templates attribute. Valid values: `WHEN_NO_MATCH`, `WHEN_NO_TEMPLATES`, `NEVER`. Default is `WHEN_NO_MATCH`. Supported only for WebSocket APIs. | `string` | `"WHEN_NO_MATCH"` | no |
| <a name="input_payload_format_version"></a> [payload\_format\_version](#input\_payload\_format\_version) | The format of the payload sent to an integration. Version-specific details can be found at https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#http-api-develop-integrations-lambda.proxy-format. Valid values: `1.0`, `2.0`. Default is `2.0`. | `string` | `"2.0"` | no |
| <a name="input_request_parameters"></a> [request\_parameters](#input\_request\_parameters) | For WebSocket APIs, an optional key-value map specifying request parameters that are passed from the method request to the backend. For HTTP APIs with a specified `integration_subtype`, a key-value map specifying parameters that are passed to `AWS_PROXY` integrations. For HTTP APIs without a specified `integration_subtype`, a key-value map specifying how to transform HTTP requests before sending them to the backend. See the Amazon API Gateway Developer Guide for details: https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-parameter-mapping.html | `map(string)` | `{}` | no |
| <a name="input_request_templates"></a> [request\_templates](#input\_request\_templates) | Optional map of Velocity templates that are applied on the request payload based on the value of the Content-Type header sent by the client. Supported only for WebSocket APIs. | `map(string)` | `{}` | no |
| <a name="input_response_parameters"></a> [response\_parameters](#input\_response\_parameters) | Optional mappings to transform the HTTP response from a backend integration before returning the response to clients. Supported only for HTTP APIs. `status_code` is in the range 200-599. For more info on configuring `mappings`, see https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-parameter-mapping.html. | <pre>list(object({<br>    status_code = number<br>    mappings    = map(string)<br>  }))</pre> | `[]` | no |
| <a name="input_template_selection_expression"></a> [template\_selection\_expression](#input\_template\_selection\_expression) | Optional template selection expression for the integration. See https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-template-selection-expressions for details. | `string` | `null` | no |
| <a name="input_timeout_milliseconds"></a> [timeout\_milliseconds](#input\_timeout\_milliseconds) | Optional custom timeout between 50 and 29,000 milliseconds for WebSocket APIs and between 50 and 30,000 milliseconds for HTTP APIs. Terraform will only perform drift detection of its value when present in a configuration. The default timeout is 29 seconds for WebSocket APIs and 30 seconds for HTTP APIs. | `number` | `null` | no |
| <a name="input_server_name_to_verify"></a> [server\_name\_to\_verify](#input\_server\_name\_to\_verify) | Optional TLS configuration for a private integration. Supported only HTTP APIs. If you specify a server name, API Gateway uses it to verify the hostname on the integration's certificate. The server name is also included in the TLS handshake to support Server Name Indication (SNI) or virtual hosting. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_integration_id"></a> [api\_gateway\_integration\_id](#output\_api\_gateway\_integration\_id) | Identifier of the Integration |
| <a name="output_api_gateway_integration_response_selection_expression"></a> [api\_gateway\_integration\_response\_selection\_expression](#output\_api\_gateway\_integration\_response\_selection\_expression) | The Integration Response Selection Expression for the Integration. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
