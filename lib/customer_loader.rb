require 'csv'

class CustomerLoader

  attr_reader :customer_repository, :customer_file

  def initialize(customer_repository, customer_file = './csvs/customers.csv' )
    @customer_repository = customer_repository
    @customer_file       = customer_file
    self.load_customers
  end

  def add_customer(id, first_name, last_name, created_at, updated_at)
    customer_repository.customers[id.to_i] = Customer.new(id.to_i,
                                                    first_name,
                                                    last_name,
                                                    created_at,
                                                    updated_at,
                                                    customer_repository)
  end

  def load_customers
    CSV.foreach(customer_file,
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
