require 'spec_helper'


describe Receipt do
  it { should have_many :products }

  it 'should know the total cost of all transactions' do
    new_receipt = Receipt.create()
    new_product = Product.create(:name => "Cracker Jacks", :cost => 1.5)
    new_transaction = Transaction.create(:product_id => new_product.id, :quantity => 3)
    new_product2 = Product.create(:name => "Rubber Chickens", :cost => 2.5)
    new_transaction2 = Transaction.create(:product_id => new_product2.id, :quantity => 12)
    new_receipt.transactions << new_transaction
    new_receipt.transactions << new_transaction2
    new_receipt.grand_total.should eq 34.5

  end
end
