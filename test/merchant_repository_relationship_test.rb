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
    result = setup.most_revenue(3)
    assert_equal "Terry-Moore", result.first.name
    assert_equal "Dicki-Bednar", result.last.name
  end

  def test_find_all_merchant_revenue_on_given_date
    date = Date.parse("Tue, 12 Mar 2012")
    result = setup.revenue(date)
    assert_equal BigDecimal.new("5531.37"), result
  end

end
