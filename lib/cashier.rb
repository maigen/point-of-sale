class Cashier < ActiveRecord::Base
  has_many :receipts
end
