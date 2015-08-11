class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repository

  def initialize(id = nil, name = nil, created_at = nil, updated_at = nil, merchant_repository = nil)
    @id                  = id
    @name                = name.to_s.delete("\"")
    @created_at          = created_at
    @updated_at          = updated_at
    @merchant_repository = merchant_repository
  end

  def items
    merchant_repository.items(id)
  end

  def invoices
    merchant_repository.invoices(id)
  end

  def revenue(date = nil)
    merchant_repository.revenue(id, date)
  end

  def favorite_customer
    merchant_repository.favorite_customer(id)
  end
end
