class Item

  attr_reader :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :item_repository

  def initialize(name = nil, description = nil, unit_price = nil, merchant_id = nil, created_at = nil, updated_at = nil, item_repository = nil)
    @name = name
    @description = description
    @unit_price = unit_price
    @merchant_id = merchant_id
    @created_at = created_at
    @updated_at = updated_at
    @item_repository = item_repository
  end

end
