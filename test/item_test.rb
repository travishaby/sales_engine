require_relative 'test_helper'
require './lib/item'

class ItemTest < Minitest::Test

  def test_it_initializes_with_nil_values
    item = Item.new
    refute item.name
    refute item.description
    refute item.unit_price
    refute item.merchant_id
    refute item.created_at
    refute item.updated_at
  end

  def test_it_initializes_with_values
    item = Item.new("name", "description", "unit_price", "merchant_id", "created_at", "updated_at")
    assert item.name
    assert item.description
    assert item.unit_price
    assert item.merchant_id
    assert item.created_at
    assert item.updated_at
  end

  def test_calling_specific_values
    item = Item.new("name", "description", "unit_price", "merchant_id", "created_at", "updated_at")
    assert_equal "name", item.name
    assert_equal "created_at", item.created_at
  end

end
