require_relative 'test_helper'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.new
    sales_engine.fixture_startup
    sales_engine.item_repository
  end

  def test_gets_invoice_items_with_item_id
    result = setup.find_by_id("3").invoice_items.size
    assert_equal 4, result
  end

  def test_gets_one_merchant_with_item_id
    result = setup.find_by_id("5").merchant.name
    assert_equal "Schroeder-Jerde", result
  end

end
