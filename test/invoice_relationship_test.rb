require_relative 'test_helper'
require './lib/invoice'
require './lib/sales_engine'
require './lib/invoice_repository'
require './lib/invoice'

class InvoiceRelationshipsTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.new
    sales_engine.fixture_startup
    sales_engine.invoice_repository
  end

  def test_gets_transactions_with_invoice_id
    result = setup.transactions(12).size
    assert_equal 3, result
  end

  def test_gets_invoice_items_with_invoice_id
    result = setup.invoice_items(12).size
    assert_equal 6, result
  end

  def test_gets_items_with_invoice_id
    result = setup.find_by_id(21).items.size
    assert_equal 3, result
  end

  def test_gets_customer_instance_associated_with_invoice
    result = setup.find_by_id(14).customer.first_name
    assert_equal "Leanne", result
  end

  def test_gets_merchant_instance_associated_with_invoice
    result = setup.find_by_id(4).merchant.name
    assert_equal "Quitzon and Sons", result
  end

end
