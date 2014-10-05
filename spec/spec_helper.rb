require 'chefspec'
require 'chefspec/server'

at_exit { ChefSpec::Coverage.report! }
