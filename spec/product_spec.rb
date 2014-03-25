require 'spec_helper'

describe Product do
  it 'can return its name and cost' do
    new_product = Product.create(:name => "Cracker Jacks")
    new_product.should be_an_instance_of Product
  end

  it { should have_one :receipt}
end
