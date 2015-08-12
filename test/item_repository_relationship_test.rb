require_relative 'test_helper'
require './lib/item'
require './lib/sales_engine'
require './lib/item_repository'

class ItemRepositoryRelationshipsTest < Minitest::Test

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

  def test_returns_top_x_items_by_revenue_generated
    skip
    result = data_setup.most_revenue(5)
    assert_equal "Item Dicta Autem", result.first.name
    assert_equal "Item Amet Accusamus", result.last.name
  end

  def test_returns_top_x_items_by_number_sold
    result = data_setup.most_items(5)
    assert_equal "Item Dicta Autem", result.first.name
    assert_equal "Item Repudiandae Quia", result.last.name
  end

end
