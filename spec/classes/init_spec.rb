require 'spec_helper'
describe 'rdorepo' do

  context 'with defaults for all parameters' do
    it { should contain_class('rdorepo') }
  end
end
