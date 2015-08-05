class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price
              :created_at,
              :updated_at

  def initialize(id = nil,
                 item_id = nil,
                 invoice_id = nil,
                 quantity = nil,
                 unit_price = nil
                 created_at = nil,
                 updated_at = nil)
    @id = id
    @item_id = item_id
    @invoice_id = invoice_id
    @quantity = quantity
    @unit_price = unit_price
    @created_at = created_at
    @updated_at = updated_at
  end

end
