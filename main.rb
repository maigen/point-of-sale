require 'active_record'
require './lib/product'
require './lib/cashier'
require './lib/customer'
require './lib/receipt'
require './lib/transaction'

database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  system "clear"
  puts "Welcome to the Kwik-E Mart.\n\n"
  menu
end

def menu
  puts "\tTo login as a manager, enter 'm',", "\tto login as a cashier, press 'c',", "\tto exit the system, press 'x'"
  choice = gets.chomp
  case choice
  when 'm'
    system "clear"
    manager_menu
  when 'c'
    system "clear"
    cashier_login
  when 'x'
    system "clear"
    puts "\n\n\n\t Thank you, come again.\n\n\n\n"
  else
    menu
  end
end
 #############################MANAGER MENU########################################
def manager_menu
  puts "\tTo add a new product, press 'p'", "\tto view list of products, press 'l'", "\tto add a new cashier, press 'n'", "\tto view list of cashiers, press 'c'.", "\tto go back to menu, press 'b'."
  choice = gets.chomp
  case choice
  when 'p'
    system "clear"
    new_product
  when 'l'
    system "clear"
    list_products
  when 'n'
    system "clear"
    new_cashier
  when 'c'
    system "clear"
    list_cashiers
  when 'b'
    system "clear"
    menu
  else
    manager_menu
  end
end

def new_product
  puts "What is the name of this product?\n\n"
  name_product = gets.chomp
  puts "What is the cost of this product?\n\n"
  cost_product = gets.chomp
  product = Product.new(:name => name_product, :cost => cost_product)
  product.save
  manager_menu
end

def list_products
  puts "Here is a list of all products in the store and their prices.\n\n"
  Product.all.each { |product| puts product.name + ": $" + ('%.2f' % product.cost).to_s }
  manager_menu
end

def new_cashier
  puts "What is the name of the new employee?\n\n"
  name_cashier = gets.chomp
  cashier = Cashier.new(:name => name_cashier)
  cashier.save
  manager_menu
end

def list_cashiers
  puts "Here is a list of all employees:\n\n"
  Cashier.all.each { |emp| puts emp.name }
  manager_menu
end

################################CASHIER MENU#################################

def cashier_login
  puts "Which cashier are you?"
  Cashier.all.each { |emp| puts emp.name }
  input = gets.chomp
  cashier = Cashier.find_by(:name => input)
  if cashier == nil
    system "clear"
    puts "There is no employee by that name."
    cashier_login
  end
  puts "Thank you for coming to work today!"
  cashier_menu(cashier)
end

def cashier_menu(cashier)
  puts "To ring up a customer, enter 'r'\n", "To check a product's price, press 'p',\n"
  input = gets.chomp
  case input
  when 'r'
    system "clear"
    transaction_menu(cashier)
  when 'p'
    system "clear"
    search_menu
  else
    puts "You are a stupid cashier. You are fired."
    cashier_menu
  end
end

def transaction_menu(cashier)
  puts "Which customer are you serving?"
  input = gets.chomp
  customer = Customer.create(:name => input)
  puts "Welcome " + customer.name + "!\n", "Thank You for shopping at Kwik-E Mart!"
  receipt = Receipt.create(:customer_id => customer.id, :cashier_id => cashier.id)

  customer_choice = false

  while customer_choice == false do
    puts "What items is " + customer.name + " purchasing?"
    Product.all.each { |product| puts product.name + ": $" + ('%.2f' % product.cost).to_s }
    product_input = gets.chomp
    product = Product.find_by(:name => product_input)
    puts "How many are they purchasing?"
    quantity = gets.chomp.to_f
    transaction = Transaction.create(:product_id => product.id, :quantity => quantity)
    receipt.transactions << transaction
    system "clear"
    puts "Would you like to make another transaction? y/n"
    input = gets.chomp.downcase
    if input == 'n'
      customer_choice = true
    end
  end
  list_transaction_items(receipt)
end

def list_transaction_items(receipt)
    puts "Here is your digital receipt. Would you like it emailed to you? y/n\n\n\n"
    receipt.transactions.each do |transaction|
      puts transaction.product.name + " x " + transaction.quantity.to_s + " @" + transaction.product.cost.to_s + " each == " + transaction.total_cost.to_s
    end
    puts "The total cost for this purchase is $" + ('%.2f' % receipt.grand_total) + ".\n"
    input = gets.chomp
    if input == 'y'
      system "clear"
      puts "Sorry, we don't currently support digital receipts. Have a nice day."
      menu
    else
      system "clear"
      puts "\n\n\n\tThank you, come again!\n\n\n"
      menu
    end
end

def search_menu
  puts "\n\nWhat product would you like to know the price of?\n\n"
  search_input = gets.chomp
  product = Product.find_by(:name => search_input)
  puts product.name + " price: $" + product.cost.to_s + "."
  cashier_menu(cashier)
end
welcome
