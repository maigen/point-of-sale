class Receipt < ActiveRecord::Base
  has_many :transactions
  has_many :products, :through => :transactions

  def grand_total
    total = []
    self.transactions.each { |transaction| total << transaction.total_cost }
    @grand_total = total.inject(:+)
  end
end
