require_relative 'test_helper'
require './lib/customer'
require './lib/sales_engine'
require './lib/customer_repository'

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

end
