class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repository

  def initialize(id = nil,
                 customer_id = nil,
                 merchant_id = nil,
                 status = nil,
                 created_at = nil,
                 updated_at = nil,
                 invoice_repository = nil)
    @id = id
    @customer_id = customer_id
    @merchant_id = merchant_id
    @status = status
    @created_at = created_at
    @updated_at = updated_at
    @invoice_repository = invoice_repository
  end

  def transactions
    @transactions ||= invoice_repository.transactions(id)
  end

  def invoice_items
    @invoice_items ||= invoice_repository.invoice_items(id)
  end

  def items
    @items ||= invoice_repository.items(id)
  end

  def customer
    @customer ||= invoice_repository.customer(customer_id)
  end

  def merchant
    @merchant ||= invoice_repository.merchant(merchant_id)
  end

end
