require_relative 'test_helper'
require './lib/item'

class ItemTest < Minitest::Test

  def test_it_initializes_with_values
    item = Item.new("id", "name", "description", "unit_price", "merchant_id", "created_at", "updated_at")
    assert item.id
    assert item.name
    assert item.description
    assert item.unit_price
    assert item.merchant_id
    assert item.created_at
    assert item.updated_at
  end

  def test_calling_specific_values
    item = Item.new("id", "name", "description", "unit_price", "merchant_id", "created_at", "updated_at")
    assert_equal "name", item.name
    assert_equal "created_at", item.created_at
  end

end
