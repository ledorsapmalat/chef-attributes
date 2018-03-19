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

require 'shellwords'

# => Define the Resource Name
resource_name :knife_attribute

# => Define the Resource Properties
property :name, default: 'kitchen-attribute'
property :level, default: 'node'
property :level_name, default: nil
property :attribute, default: nil
property :value, default: nil

#
# => Define the Default Resource Action
#
actions :install, :remove, :set
default_action :install

#
# => Install
#
action :install do
  unless dependencies_installed?
    converge_by(" Install Gem #{new_resource} Dependencies ") do
      install_gem_dependencies
    end
  end
  if package_exists?
    Chef::Log.info "#{new_resource} already set - nothing to do."
  else
    converge_by(" Install Gem #{new_resource}") do
      install_knife_attribute
    end
  end
end

action :remove do
  unless dependencies_installed?
    converge_by(" Install Gem #{new_resource} Dependencies ") do
      install_gem_dependencies
    end
  end
  if package_exists?
    converge_by(" Remove Gem #{new_resource} ") do
      delete_knife_attribute
    end
  else
    Chef::Log.info "#{new_resource} not found - nothing to do."
  end
end

action :set do
  action_install
  if !new_resource.attribute.empty? && !new_resource.value.empty? && !new_resource.level_name.empty?
    converge_by(" Set Gem #{new_resource}") do
      set_knife_attribute
    end
  end
end

action_class do
  def dependencies_installed?
    ::File.exist?('/root/._gem_dependencies_installed')
  end

  def package_exists?
    ::File.exist?('/root/._knife_attribute_installed')
  end

  def install_knife_attribute
    gem_package "knife-attribute" do
      source "http://gems"
    end
    file '/root/._knife_attribute_installed' do
      owner 'root'
      group 'root'
      mode '0755'
      action :create
    end
  end

  def delete_knife_attribute
    gem_package "knife-attribute" do
      source "http://gems"
      action :purge
    end
    file '/root/._knife_attribute_installed' do
      owner 'root'
      group 'root'
      mode '0755'
      action :delete
    end
  end

  def set_knife_attribute
    bash "set_#{new_resource.level}_#{new_resource.attribute}_#{new_resource.value}" do
      code <<-EOH
        code "knife #{new_resource.level} attribute set #{new_resource.level_name} #{new_resource.attribute} #{new_resource.value} -t override "
      EOH
    end
  end

  def install_gem_dependencies
    package 'rubygems'
    package 'ruby-dev'
    package 'ruby-all-dev'
    package 'make'
    package 'gcc'
    file '/root/._gem_dependencies_installed' do
      owner 'root'
      group 'root'
      mode '0755'
      action :create
    end
  end
end
