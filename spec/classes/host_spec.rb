require 'spec_helper'


describe 'definer' do

  let(:title) { 'definer' }
  let(:node) { 'rspec.adaptavist.com' }

  describe 'Hosts should be created' do
    let(:params) do
      {
        :defs => {
          'host' => {
            'foobarhost' => {
              'name' => 'myhost',
              'host_aliases' => ['foo','bar'],
              'ip' => '1.2.3.4'
            },
            'testhost' => {
              'host_aliases' => 'test',
              'ip' => '4.3.2.1'
            }
          }
        }
      }
    end
    it 'The host foobarhost should be created' do
      should contain_host('foobarhost').with('ip' => '1.2.3.4',
                                             'name' => 'myhost',
                                             'host_aliases' => ['foo', 'bar'])
      should contain_host('testhost').with('ip' => '4.3.2.1',
                                           'name' => 'testhost',
                                           'host_aliases' => 'test')

    end
  end
end
