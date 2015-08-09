require_relative 'test_helper'
require './lib/transaction'
require './lib/sales_engine'

class TransactionRelationshipTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.new
    sales_engine.fixture_startup
    sales_engine.transaction_repository
  end

  def test_invoices_with_invoice_id
    result = setup.find_by_id("10").invoices.size
    assert_equal 1, result
  end

end
