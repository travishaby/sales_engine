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
    @merchant ||= item_repository.merchant(merchant_id)
  end

  def successful_invoice_items
    @successful ||= merchant.successful_invoice_items.select do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def revenue
    @revenue ||= successful_invoice_items.reduce(0) do |sum, invoice_item|
      sum + invoice_item.total_cost
    end
  end

  def items_sold
    @items_sold ||= successful_invoice_items.reduce(0) do |sum, invoice_item|
      sum + invoice_item.quantity
    end
  end

  def best_day
    invoice_items_sorted_by_quantity =
    successful_invoice_items.sort_by do |invoice_item|
      invoice_item.quantity
    end
    best_seller = invoice_items_sorted_by_quantity.reverse.first
    Date.parse(best_seller.invoice.created_at)
  end

end
