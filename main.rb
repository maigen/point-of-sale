require 'active_record'
require './lib/product'
require './lib/cashier'

database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  system "clear"
  puts "Welcome to the Kwik-E Mart.\n\n"
  menu
end

def menu
  puts "\tTo login as a manager, enter 'm',", "\tto login as a cashier, press 'c',", "\tto login as a customer, press 'l',", "\tto exit the system, press 'x'"
  choice = gets.chomp
  case choice
  when 'm'
    system "clear"
    manager_menu
  when 'c'
    system "clear"
    cashier_menu
  when 'l'
    system "clear"
    customer_menu
  when 'x'
    system "clear"
    puts "\n\n\n\t Thank you, come again.\n\n\n\n"
  else
    menu
  end
end

def manager_menu
  puts "\tTo add a new product, press 'p'", "\tto view list of products, press 'l'", "\tto add a new cashier, press 'n'", "\tto view list of cashiers, press 'c'."
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
end


welcome
