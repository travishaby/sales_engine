require_relative 'customer'
require_relative 'customer_loader'

class CustomerRepository

  attr_reader :customers

  def initialize
    @customers = {}
  end

  def customer_loader
    CustomerLoader.new(self)
  end

end
