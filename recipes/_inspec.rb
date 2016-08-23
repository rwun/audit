# encoding: utf-8
#
# Cookbook Name:: compliance
# Recipe:: inspec
#
# Copyright 2016 Chef Software, Inc.
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

inspec_version = node['audit']['inspec_version']

# install inspec if require
chef_gem 'inspec' do
  version inspec_version if inspec_version != 'latest'
  compile_time true
  action :install
end

# verify the right inspec version
require 'inspec'
# check we have the right inspec version
if Inspec::VERSION != inspec_version && inspec_version !='latest'
  Chef::Log.warn "Wrong version of inspec (#{Inspec::VERSION}), please "\
    'remove old versions (/opt/chef/embedded/bin/gem uninstall inspec).'
else
  Chef::Log.warn "Using inspec version: (#{Inspec::VERSION})"
end
