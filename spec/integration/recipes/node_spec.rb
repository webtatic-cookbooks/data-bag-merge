require 'spec_helper'

describe 'data-bag-merge::node' do
  before do
    ChefSpec::Server.create_data_bag('nodes',
      'staging-node-1' => {
        'id' => 'staging-node-1',
        'default_attributes' => {
          'item_with_default' => 'default value',
          'item_with_normal' => 'default value'
        },
        'override_attributes' => {
          'item_with_override' => 'override value'
        }
      }
    )
  end

  context 'with node.name "staging-node-1" and unencrypted data_bag item "nodes/staging-node-1"' do

    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['data-bag-merge']['nodes']['encrypted'] = false
        node.set['item_with_normal'] = 'normal value'
        node.set['item_with_override'] = 'normal value'
        node.name 'staging-node-1'
      end.converge(described_recipe)
    end

    it 'sets attributes according to precedence' do
      expect(chef_run.node['item_with_default']).to eq 'default value'
      expect(chef_run.node['item_with_normal']).to eq 'normal value'
      expect(chef_run.node['item_with_override']).to eq 'override value'
    end

  end
end
