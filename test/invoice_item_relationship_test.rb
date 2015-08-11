require_relative 'test_helper'
require './lib/invoice_item'
require './lib/sales_engine'
require './lib/invoice_item_repository'

class InvoiceItemRelationshipTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.new
    sales_engine.fixture_startup
    sales_engine.invoice_item_repository
  end

  def test_return_invoice_with_invoice_id
    result = setup.find_by_id("9").invoice.id
    assert_equal "2", result
  end

  def test_return_item_with_item_id
    result1 = setup.find_by_id("100").item.id
    result2 = setup.find_by_id("100").item.unit_price
    assert_equal "3", result1
    assert_equal BigDecimal.new("323.01"), result2
  end


end
