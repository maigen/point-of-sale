require 'spec_helper'


describe Receipt do
  it { should have_many :products }
end
