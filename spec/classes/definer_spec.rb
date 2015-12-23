require 'spec_helper'
 
defs_to_fail = 'wrong input'

defs = {
  'user' => {
    'user1' => {'name'=>'user1'},
    'user2' => {'name'=>'user2'},
    },
  'host' => {
    'host1' => {'name' => 'myhost',
              'ip' => '1.2.3.4'},
    },
}

describe 'definer', :type => 'class' do
    
  context "Should validate input with required parameter $defs" do
    it { expect { should contain_definer__helper('') }.to raise_error(Puppet::Error) }
  end
  
  context "Should validate input with required parameter $defs as hash" do
    let(:params){{ :defs => defs_to_fail}}
    it { expect { should contain_definer__helper('') }.to raise_error(Puppet::Error) }
  end

  context "Should validate required parameter $defs as hash" do
    let(:params){{ :defs => defs}}

    it do
      should contain_definer__helper('user').with(
        'params' => defs
      )

      should contain_definer__helper('host').with(
        'params' => defs
      )
    end

    
  end
end
