require_relative 'test_helper'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryRelationshipTest < Minitest::Test

  # def setup
  #   sales_engine = SalesEngine.new
  #   sales_engine.fixture_startup
  #   sales_engine
  # end

  def data_setup
    @sales_engine ||= SalesEngine.new
    @sales_engine.startup
    @sales_engine
  end

  def customer
    @customer ||= data_setup.customer_repository.find_by_id(10)
  end

  def merchant
    @merchant ||= data_setup.merchant_repository.find_by_id(11)
  end

  def item1
    @item1 ||= data_setup.item_repository.find_by_id(1)
  end

  def item2
    @item2 ||= data_setup.item_repository.find_by_id(2)
  end

  def item3
    @item3 ||= data_setup.item_repository.find_by_id(3)
  end

  def create_invoice
    data_setup.invoice_repository.create(
             customer: customer,
             merchant: merchant,
             status: "shipped",
             items: [item1, item2, item3])
  end

  def test_it_creates_a_new_invoice
    skip
    assert_equal 4843, data_setup.invoice_repository.invoices.size
    assert_equal 21687, data_setup.invoice_item_repository.invoice_items.size
    create_invoice
    assert_equal 4844, data_setup.invoice_repository.invoices.size
    assert_equal 21690, data_setup.invoice_item_repository.invoice_items.size
  end

  def test_created_invoice_has_correct_info
    create_invoice
    invoice = data_setup.invoice_repository.invoices[4844]
    assert_equal customer.id, invoice.customer_id
    assert_equal merchant.id, invoice.merchant_id
  end

  def test_created_invoice_item_has_correct_info
    create_invoice
    invoice_item1 = data_setup.invoice_item_repository.invoice_items[21688]
    invoice_item2 = data_setup.invoice_item_repository.invoice_items[21689]
    assert_equal item1.id, invoice_item1.item_id
    assert_equal item2.id, invoice_item2.item_id
  end

end
