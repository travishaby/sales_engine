class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repository

  def initialize(id = nil,
                name = nil,
                created_at = nil,
                updated_at = nil,
                merchant_repository = nil)
    @id                  = id
    @name                = name.to_s.delete("\"")
    @created_at          = created_at
    @updated_at          = updated_at
    @merchant_repository = merchant_repository
  end

  def items
    @items ||= merchant_repository.items(id)
  end

  def invoices
    @invoices ||= merchant_repository.invoices(id)
  end

  def merchant_transactions
    @merchant_transactions ||= invoices.map do |invoice|
      invoice.transactions
    end
  end

  def filter_successful_transactions
    @filter_successful_transactions ||= merchant_transactions.flatten.select do |transaction|
      transaction.result == "success"
    end
  end

  def filter_pending_invoices
    invoices.select do |invoice|
      invoice if all_transactions_failed?(invoice)
    end
  end

  def all_transactions_failed?(invoice)
    invoice.transactions.none? do |transaction|
      transaction.result == "success"
    end
  end

  def successful_invoices
    filter_successful_transactions.map do |transaction|
      transaction.invoice
    end
  end

  def filter_invoices_for_date(date = nil)
    if date
      successful_invoices.select do |invoice|
        same_date?(invoice, date)
      end
    else
      successful_invoices
    end
  end

  def same_date?(invoice, date)
    created_at = invoice.created_at[0..9]
    Date.parse(created_at) == date
  end

  def successful_items(date = nil)
    filter_invoices_for_date(date).map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def items_sold(date = nil)
    successful_items(date).reduce(0) do |sum, invoice_item|
      sum + invoice_item.quantity
    end
  end

  def revenue(date = nil)
    successful_items(date).reduce(0) do |sum, invoice_item|
      sum + invoice_item.total_cost
    end
  end

  def favorite_customer
    grouped = successful_invoices.group_by do |invoice|
      invoice.customer_id
    end
    sorted = grouped.values.sort_by {|array| array.size}
    best_customer_invoice = sorted.last[0]
    customer_name = best_customer_invoice.customer
  end

  def customers_with_pending_invoices
    filter_pending_invoices.map do |invoice|
      invoice.customer
    end
  end

end
