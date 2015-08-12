class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repository

  def initialize(id = nil,
                first_name = nil,
                last_name = nil,
                created_at = nil,
                updated_at = nil,
                customer_repository = nil)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @created_at = created_at
    @updated_at = updated_at
    @customer_repository = customer_repository
  end


  def invoices
    customer_repository.invoices(id)
  end

end
