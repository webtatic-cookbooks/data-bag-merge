#
# Cookbook Name:: data-bag-merge
# Recipe:: environment
#
# Copyright 2014, Andy Thompson
#
# Licensed under the MIT license

if node['data-bag-merge']['environments']['encrypted']
  encrypted_data_bag_merge "environments/#{node.chef_environment}" do
    secret_path node['data-bag-merge']['environments']['secret_path']
    data_bag node['data-bag-merge']['environments']['data_bag_name']
    item node.chef_environment
  end
else
  data_bag_merge "environments/#{node.chef_environment}" do
    data_bag node['data-bag-merge']['environments_data_bag_name']
    item node.chef_environment
  end
end
