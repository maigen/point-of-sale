require 'rspec'
require 'active_record'
require 'shoulda-matchers'

require 'product'
require 'cashier'
require 'receipt'
require 'customer'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Product.all.each { |product| product.destroy }
    Cashier.all.each { |cashier| cashier.destroy }
    Receipt.all.each { |receipt| receipt.destroy }
  end
end
