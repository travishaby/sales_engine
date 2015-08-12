require_relative 'test_helper'
require './lib/merchant'
require './lib/sales_engine'
require './lib/merchant_repository'
require 'pry'

class MerchantRepositoryRelationshipsTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.new
    sales_engine.fixture_startup
    sales_engine.merchant_repository
  end
  
  def data_setup
    sales_engine = SalesEngine.new
    sales_engine.startup
    sales_engine.merchant_repository
  end

  def test_find_top_x_merchant_revenue
    skip
    result = setup.most_revenue(3)
    assert_equal "Terry-Moore", result.first.name
    assert_equal "Dicki-Bednar", result.last.name
  end

  def test_find_all_merchant_revenue_on_given_date
    skip
    date = Date.parse("Tue, 12 Mar 2012")
    result = setup.revenue(date)
    assert_equal BigDecimal.new("5531.37"), result
  end

  def test_returns_top_x_merchants_with_most_items_sold
    result = data_setup.most_items(5)
    assert_equal "Kassulke, O'Hara and Quitzon", result.first.name
    assert_equal "Daugherty Group", result.last.name
  end

end
