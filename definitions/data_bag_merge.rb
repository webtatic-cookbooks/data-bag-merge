#
# Cookbook Name:: data-bag-merge
# Definition:: data_bag_merge
#
# Copyright 2014, Andy Thompson
#
# Licensed under the MIT license

define :data_bag_merge do
  if params[:data_bag].nil?
    bag_item_name = params[:name].split('/')
    params[:data_bag] = bag_item_name[0]
    params[:item] = bag_item_name[1]
  end

  data_bag_data = Chef::DataBagItem.load(params[:data_bag], params[:item]).to_hash
  data_bag_data.delete 'id'

  Chef::Mixin::DeepMerge.deep_merge! data_bag_data, node.default
end