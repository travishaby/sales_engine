require_relative 'test_helper'
require './lib/merchant'
require './lib/sales_engine'
require './lib/merchant_repository'

class MerchantRelationshipsTest < Minitest::Test

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

  def test_gets_items_with_merchant_id
    result = setup.find_by_name("Williamson Group").items.size
    assert_equal 9, result
  end

  def test_gets_invoices_with_merchant_id
    result = setup.find_by_name("Rutherford, Bogan and Leannon").invoices.size
    assert_equal 2, result
  end

  def test_returns_total_merchant_revenue
    result = data_setup.find_by_name("Willms and Sons").revenue
    assert_equal BigDecimal.new("338055.54"), result
  end

  def test_revenue_by_date
    # can we use the above and add a default date argument?
  end

  def test_returns_customer_with_most_successful_transactions
    # find all invoices with merchant id.

  end

  def test_returns_customers_with_pending_invoices
    #all invoices say shipped??
  end

end
