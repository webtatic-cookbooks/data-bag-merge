require 'spec_helper'

describe 'data-bag-merge::environment' do
  before do
    ChefSpec::Server.create_data_bag('environments',
      'staging' => {
        'id' => 'staging',
        'default_attributes' => {
          'item_with_default' => 'default value',
          'item_with_normal' => 'default value'
        },
        'override_attributes' => {
          'item_with_override' => 'override value'
        }
      }
    )
    ChefSpec::Server.create_environment('staging', {})
  end

  context 'with chef_environment "staging" and unencrypted data_bag item "environments/staging"' do

    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['data-bag-merge']['environments']['encrypted'] = false
        node.set['item_with_normal'] = 'normal value'
        node.set['item_with_override'] = 'normal value'
        node.chef_environment 'staging'
      end.converge(described_recipe)
    end

    it 'sets attributes according to precedence' do
      expect(chef_run.node['item_with_default']).to eq 'default value'
      expect(chef_run.node['item_with_normal']).to eq 'normal value'
      expect(chef_run.node['item_with_override']).to eq 'override value'
    end

  end
end
