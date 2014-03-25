class Receipt < ActiveRecord::Base
  has_many :products, :through => :products_receipts
end
