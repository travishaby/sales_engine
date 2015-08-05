require 'csv'

class CustomerLoader

  attr_reader :customer_repository

  def initialize(customer_repository)
    @customer_repository = customer_repository
  end

  def add_customer(id, first_name, last_name, created_at, updated_at)
    customer_repository.customers[id] = Customer.new(id,
                                                    first_name,
                                                    last_name,
                                                    created_at,
                                                    updated_at)
  end

  def load_customers
    CSV.foreach('./data/customers.csv',
                headers: true,
                header_converters: :symbol) do |row|
      add_customer(row[:id],
                  row[:first_name],
                  row[:last_name],
                  row[:created_at],
                  row[:updated_at])
    end
    customer_repository.customers
  end

end
