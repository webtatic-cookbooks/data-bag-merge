#
# Cookbook Name:: data-bag-merge
# Recipe:: node
#
# Copyright 2014, Andy Thompson
#
# Licensed under the MIT license

item_name = node.name.gsub(/[^\-[:alnum:]]+/, '_')
config = node['data-bag-merge']['nodes']

if config['encrypted']
  encrypted_data_bag_merge "#{config['data_bag_name']}/#{item_name}" do
    format config['format']
    secret_path config['secret_path']
    data_bag config['data_bag_name']
    item item_name
  end
else
  data_bag_merge "#{config['data_bag_name']}/#{item_name}" do
    format config['format']
    data_bag config['data_bag_name']
    item item_name
  end
end
