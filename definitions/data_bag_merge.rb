#
# Cookbook Name:: data-bag-merge
# Definition:: data_bag_merge
#
# Copyright 2014, Andy Thompson
#
# Licensed under the MIT license

define :data_bag_merge, :format => 'default' do
  if params[:data_bag].nil?
    bag_item_name = params[:name].split('/')
    params[:data_bag] = bag_item_name[0]
    params[:item] = bag_item_name[1]
  end

  data_bag_data = Chef::DataBagItem.load(params[:data_bag], params[:item]).to_hash
  data_bag_data.delete 'id'

  case params[:format]
  when 'default'
    Chef::Mixin::DeepMerge.deep_merge! data_bag_data, node.default
  when 'override'
    Chef::Mixin::DeepMerge.deep_merge! data_bag_data, node.override
  when 'default_override'
    if data_bag_data.key?('default_attributes')
      Chef::Mixin::DeepMerge.deep_merge! data_bag_data['default_attributes'], node.default
    end
    if data_bag_data.key?('override_attributes')
      Chef::Mixin::DeepMerge.deep_merge! data_bag_data['override_attributes'], node.override
    end
  end
end
