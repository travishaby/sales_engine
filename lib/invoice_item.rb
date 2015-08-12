require 'bigdecimal'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :invoice_item_repository

  def initialize(id = nil,
                 item_id = nil,
                 invoice_id = nil,
                 quantity = nil,
                 unit_price = nil,
                 created_at = nil,
                 updated_at = nil,
                 invoice_item_repository = nil)
    @id = id
    @item_id = item_id
    @invoice_id = invoice_id
    @quantity = quantity
    @unit_price = (BigDecimal.new(unit_price)/100)
    @created_at = created_at
    @updated_at = updated_at
    @invoice_item_repository = invoice_item_repository
  end

  def invoice
    @invoice ||= invoice_item_repository.invoice(invoice_id)
  end

  def item
    @item ||= invoice_item_repository.item(item_id)
  end

  def total_cost
    quantity * unit_price
  end

end
