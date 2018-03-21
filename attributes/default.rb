#
# Cookbook:: chef-attributes
# attribute:: default
#
# Copyright (C) 2018,  Rodel Manalo Talampas
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

default['chef']['configuration'] = '/etc/chef/user.rb'

# knife-attribute plugin can manipulate chef attributes via knife
# Install via Gem or Chef Gem - https://github.com/pdf/knife-attribute
# It can manipulate environment, role and node level attributes
default['chef']['level']['attributes'] = {
  # override this value
  'environment' => {
    'Development' => {
      'env.attribute.period.concatenated' => 'value',
      'env.attribute.period.concatenated2' => 'value'
    },
    # 'Production' => {
    #   'attribute.period.concatenated3' => 'value',
    #   'attribute.period.concatenated4' => 'value'
    # }
  },
  'role' => {
    'dev-role' => {
      'role.attribute.period.concatenated' => 'value',
      'role.attribute.period.concatenated2' => 'value'
    },
  },
  # 'node' => {
  #   'node-101' => {
  #     'node.attribute.period.concatenated' => 'value',
  #     'node.attribute.period.concatenated2' => 'value'
  #   }
  # }
}
