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

output "api_gateway_id" {
  value = module.api_gateway.api_gateway_id
}

output "api_protocol_type" {
  value = module.api_gateway.api_protocol_type
}

output "api_gateway_integration_id" {
  value = module.api_gateway_integration.api_gateway_integration_id
}

output "api_gateway_integration_response_selection_expression" {
  value = module.api_gateway_integration.api_gateway_integration_response_selection_expression
}
