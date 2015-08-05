require_relative 'customer'
require_relative 'customer_loader'

class CustomerRepository

  attr_reader :customers, :customer_file

  def initialize(customer_file = './data/customers.csv')
    @customers = {}
    @customer_file = customer_file
  end

  def customer_loader
    CustomerLoader.new(self)
  end

end
