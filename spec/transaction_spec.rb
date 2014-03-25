require 'spec_helper'

describe Transaction do
  it { should belong_to :product }
  it { should belong_to :receipt }

  it 'should have a total_cost based on its product and the amount purchased'  do
    new_product = Product.create(:name => "Cracker Jacks", :cost => 1.5)
    new_transaction = Transaction.create(:product_id => new_product.id, :quantity => 3)
    new_transaction.total_cost.should eq 4.5
  end
end
