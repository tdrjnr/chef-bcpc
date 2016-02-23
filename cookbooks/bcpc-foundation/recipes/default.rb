#
# Cookbook Name:: bcpc-foundation
# Recipe:: default
#
# Copyright 2015, Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'bcpc-foundation::certs'
include_recipe 'bcpc-foundation::cpupower'
include_recipe 'bcpc-foundation::deadline-io-scheduler'
include_recipe 'bcpc-foundation::developer'
include_recipe 'bcpc-foundation::packages-common'
include_recipe 'bcpc-foundation::packages-debugging'
include_recipe 'bcpc-foundation::swap'
include_recipe 'bcpc-foundation::tpm'
