#
# Cookbook Name:: data-bag-merge
# Attributes:: data-bag-merge
#
# Copyright 2014, Andy Thompson
#
# Licensed under the MIT license

default['data-bag-merge']['environments']['data_bag_name'] = 'environments'
default['data-bag-merge']['environments']['encrypted'] = true
default['data-bag-merge']['environments']['secret_path'] = nil

default['data-bag-merge']['nodes']['data_bag_name'] = 'nodes'
default['data-bag-merge']['nodes']['encrypted'] = true
default['data-bag-merge']['nodes']['secret_path'] = nil
