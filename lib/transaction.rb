class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :transaction_repository

  def initialize(id = nil,
                invoice_id = nil,
                credit_card_number = nil,
                credit_card_expiration_date = nil,
                result = nil,
                created_at = nil,
                updated_at = nil,
                transaction_repository = nil)
    @id = id
    @invoice_id = invoice_id
    @credit_card_number = credit_card_number
    @credit_card_expiration_date = credit_card_expiration_date
    @result = result
    @created_at = created_at
    @updated_at = updated_at
    @transaction_repository = transaction_repository
  end

  def invoice
    transaction_repository.invoice(invoice_id)
  end

end
