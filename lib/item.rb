require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :item_repository

  def initialize(id = nil,
                 name = nil,
                 description = nil,
                 unit_price = nil,
                 merchant_id = nil,
                 created_at = nil,
                 updated_at = nil,
                 item_repository = nil)
    @id = id
    @name = name
    @description = description
    @unit_price = (BigDecimal.new(unit_price)/100)
    @merchant_id = merchant_id
    @created_at = created_at
    @updated_at = updated_at
    @item_repository = item_repository
  end

  def invoice_items
    item_repository.invoice_items(id)
  end

  def merchant
    item_repository.merchant(merchant_id)
  end

end
