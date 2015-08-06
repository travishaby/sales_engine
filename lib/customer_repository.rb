require_relative 'customer'
require_relative 'customer_loader'

class CustomerRepository

  attr_reader :customers, :customer_file, :engine

  def initialize(engine = nil, customer_file = './data/customers.csv')
    @customers = {}
    @customer_file = customer_file
    @engine = engine
  end

  def customer_loader
    CustomerLoader.new(self)
  end

  def all
    customers.values
  end

  def random
    customers.values.to_a.sample
  end

  def find_by_id(id)
    customers[id]
  end

  def find_by_first_name(first_name)
    customers.detect do |id, object|
      object.first_name == first_name
    end
  end

  def find_by_last_name(last_name)
    customers.detect do |id, object|
      object.last_name == last_name
    end
  end

  def find_by_created_at(created_at)
    customers.detect do |id, object|
      object.created_at == created_at
    end
  end

  def find_by(attribute, match)
    customers.detect do |id, object|
      object.send(attribute) == match
    end
  end

  def find_by_updated_at(updated_at)
    find_by(:updated_at, updated_at)
  end

  def find_all_by_last_name(last_name)
    customers.select do |id, object|
      object.last_name == last_name
    end
  end

end
