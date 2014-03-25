class Product < ActiveRecord::Base
  has_one :receipt, :through => :products_receipts
end
