#
# Cookbook Name:: data-bag-merge
# Definition:: encrypted_data_bag_merge
#
# Copyright 2014, Andy Thompson
#
# Licensed under the MIT license

define :encrypted_data_bag_merge, :bag_format => 'default' do
  if params[:secret_path].nil?
    databag_secret = nil
  else
    databag_secret = Chef::EncryptedDataBagItem.load_secret(params[:secret_path])
  end

  if params[:data_bag].nil?
    bag_item_name = params[:name].split('/')
    params[:data_bag] = bag_item_name[0]
    params[:item] = bag_item_name[1]
  end

  data_bag_data = Chef::EncryptedDataBagItem.load(params[:data_bag], params[:item], databag_secret).to_hash
  data_bag_data.delete 'id'

  case params[:bag_format]
  when 'default'
    Chef::Mixin::DeepMerge.deep_merge! data_bag_data, node.default
  when 'override'
    Chef::Mixin::DeepMerge.deep_merge! data_bag_data, node.override
  when 'default_override'
    unexpected_keys = data_bag_data.keys - %w( default_attributes override_attributes )
    if unexpected_keys.count > 0
      Chef::Application.fatal! "Unexpected keys #{unexpected_keys.join(',')} \
found in #{params[:data_bag]}/#{params[:item]} data bag"
    end

    if data_bag_data.key?('default_attributes')
      Chef::Mixin::DeepMerge.deep_merge! data_bag_data['default_attributes'], node.default
    end
    if data_bag_data.key?('override_attributes')
      Chef::Mixin::DeepMerge.deep_merge! data_bag_data['override_attributes'], node.override
    end
  end
end
