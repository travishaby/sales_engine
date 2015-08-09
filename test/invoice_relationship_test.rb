require_relative 'test_helper'
require './lib/invoice'
require './lib/sales_engine'
require './lib/invoice_repository'

class InvoiceRelationshipsTest < Minitest::Test

  # def setup
  #   sales_engine = SalesEngine.new
  #   invoice_repository = InvoiceRepository.new(sales_engine)
  #   invoice_loader = InvoiceLoader.new(invoice_repository, './fixtures/invoices.csv')
  #   item_repository = ItemRepository.new(sales_engine)
  #   item_loader = ItemLoader.new(item_repository, './fixtures/items.csv')
  #   # require 'pry'; binding.pry
  #   invoice_repository
  # end

  def setup
    sales_engine = SalesEngine.new
    sales_engine.fixture_startup
    sales_engine.invoice_repository
  end

  def test_returns_associated_transactions
    result = setup.find_by_id("12")[1].transactions.size
    assert_equal 3, result
  end

  def test_gets_invoices_with_invoice_id
    skip
    result = setup.find_by_name("Rutherford, Bogan and Leannon")[1].invoices.size
    assert_equal 2, result
  end

  end
