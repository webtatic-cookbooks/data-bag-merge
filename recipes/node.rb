#
# Cookbook Name:: data-bag-merge
# Recipe:: node
#
# Copyright 2014, Andy Thompson
#
# Licensed under the MIT license

item_name = node.name.gsub(/[^\-[:alnum:]]+/, '_')

if node['data-bag-merge']['environments']['encrypted']
  encrypted_data_bag_merge "environments/#{item_name}" do
    secret_path node['data-bag-merge']['nodes']['secret_path']
    data_bag node['data-bag-merge']['nodes']['data_bag_name']
    item item_name
  end
else
  data_bag_merge "environments/#{item_name}" do
    data_bag node['data-bag-merge']['nodes']['data_bag_name']
    item item_name
  end
end