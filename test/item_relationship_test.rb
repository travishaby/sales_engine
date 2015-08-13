require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.new
    sales_engine.fixture_startup
    sales_engine.item_repository
  end

  def data_setup
    sales_engine = SalesEngine.new
    sales_engine.startup
    sales_engine.item_repository
  end

  def test_gets_invoice_items_with_item_id
    result = setup.find_by_id(3).invoice_items.size
    assert_equal 4, result
  end

  def test_gets_one_merchant_with_item_id
    result = setup.find_by_id(5).merchant.name
    assert_equal "Schroeder-Jerde", result
  end

  def test_gets_total_revenue_for_item
    skip
    result = data_setup.find_by_id(5).revenue
    assert_equal BigDecimal.new("69410.23"), result
  end

  def test_gets_total_sold_for_item
    skip
    result = data_setup.find_by_id(3).items_sold
    assert_equal 91, result
  end

  def test_best_day_for_item
    skip
    result = data_setup.find_by_name("Item Accusamus Ut").best_day
    date = Date.parse("2012-03-24")
    assert_equal date, result
  end

end
