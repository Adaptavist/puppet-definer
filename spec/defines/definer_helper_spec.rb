# #
# # = define definer::helper
# # helper define for the definer class
# define definer::helper (
#   $params
#   ){
#   validate_hash($params)
#   $p = $params[$name]
#   validate_hash($p)
#   create_resources($title, $p)
# }

require 'spec_helper'
params_to_fail = 'wrong input'

params_as_hash_incorrect = {
  'user' => [
    'user1',
    'user2',
    ],
}

params = {
  'user' => {
    'user1' => {'name'=>'user1'},
    'user2' => {'name'=>'user2'},
    },
  'host' => {
    'host1' => {'name' => 'myhost',
              'ip' => '1.2.3.4'},
    },
}
def_title = 'user'

describe 'definer::helper', :type => 'define' do
    let :title do
      def_title
    end
    
	context "Should validate input with required parameter $params" do
		it { expect { should contain_user('user1') }.to raise_error(Puppet::Error) }
	end

	context "Should validate input with required parameter $params as hash" do
		let(:params){{ :params => params_to_fail}}
		it { expect { should contain_user('user1') }.to raise_error(Puppet::Error) }
	end

	context "Should validate input with required parameter $params as hash with values to be hash" do
		let(:params){{ :params => params_as_hash_incorrect}}
		it { expect { should contain_user('user1') }.to raise_error(Puppet::Error) }
	end
	
	context "Should create user resources based on params hash, but not host as name of define is user" do
		# should be checking here that crete_resources is called with params 
		# not that the resources are created as this is unit test
		let(:params){{ :params => params}}
		it { 
			should contain_user('user1').with(
				'name' => 'user1',
			)
			should contain_user('user2').with(
				'name' => 'user2',
			)
			should_not contain_host('host1').with(
				'name' => 'myhost',
				'ip' => '1.2.3.4',
			)
		}
	end

end
