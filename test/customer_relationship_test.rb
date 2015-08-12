require_relative 'test_helper'
require './lib/customer'
require './lib/sales_engine'

class CustomerRelationshipTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.new
    sales_engine.fixture_startup
    sales_engine.customer_repository
  end

  def test_gets_items_with_customer_id
    result = setup.find_by_id(4).invoices.size
    assert_equal 8, result
  end

  ######### BUSINESS INTELLIGENCE #########

  def test_transactions_returns_customer_transactions
    customer = setup.find_by_id(2)
    result = customer.transactions.size
    assert_equal 1, result
  end

  def test_favorite_merchant_for_customer
    customer = setup.find_by_id(2)
    result = customer.favorite_merchant.name
    assert_equal "Shields, Hirthe and Smith", result
  end

end
