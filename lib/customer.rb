class Customer < ActiveRecord::Base
  has_many :receipts
end
