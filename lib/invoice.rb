class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(id = nil,
                 customer_id = nil,
                 merchant_id = nil,
                 status = nil,
                 created_at = nil,
                 updated_at = nil)
    @id = id
    @customer_id = customer_id
    @merchant_id = merchant_id
    @status = status
    @created_at = created_at
    @updated_at = updated_at
  end

end
