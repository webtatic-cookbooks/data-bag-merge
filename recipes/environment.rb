#
# Cookbook Name:: data-bag-merge
# Recipe:: environment
#
# Copyright 2014, Andy Thompson
#
# Licensed under the MIT license

item_name = node.chef_environment.gsub(/[^\-[:alnum:]]+/, '_')
config = node['data-bag-merge']['environments']

if config['encrypted']
  encrypted_data_bag_merge "#{config['data_bag_name']}/#{item_name}" do
    secret_path config['secret_path']
    bag_format config['bag_format']
    data_bag config['data_bag_name']
    item item_name
  end
else
  data_bag_merge "#{config['data_bag_name']}/#{item_name}" do
    bag_format config['bag_format']
    data_bag config['data_bag_name']
    item item_name
  end
end
