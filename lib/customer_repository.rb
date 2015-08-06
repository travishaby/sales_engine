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

  def find_by(attribute, match)
    found = customers.detect do |id, object|
      object.send(attribute).downcase == match.downcase
    end
    found || empty = []
  end

  def find_by_first_name(first_name)
    find_by(:first_name, first_name)
  end

  def find_by_last_name(last_name)
    find_by(:last_name, last_name)

  end

  def find_by_created_at(created_at)
    find_by(:created_at, created_at)

  end

  def find_by_updated_at(updated_at)
    find_by(:updated_at, updated_at)
  end

  def find_by_all(attribute, match)
    found = customers.select do |id, object|
      object.send(attribute).downcase == match.downcase
    end
    found || empty = []
  end

  def find_all_by_id(id)
    find_by_all(:id, id)
  end

  def find_all_by_first_name(first_name)
    find_by_all(:first_name, first_name)
  end

  def find_all_by_last_name(last_name)
    find_by_all(:last_name, last_name)
  end

  def find_all_by_created_at(created_at)
    find_by_all(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_by_all(:updated_at, updated_at)
  end

end
