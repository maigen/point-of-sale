class Transaction < ActiveRecord::Base
  attr_reader :total_cost

  belongs_to :receipt
  belongs_to :product

  def total_cost
    @total_cost = self.product.cost.to_f * self.quantity
  end
end
