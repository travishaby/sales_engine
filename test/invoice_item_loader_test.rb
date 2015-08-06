require_relative 'test_helper'
require './lib/invoice_item_loader'
require './lib/invoice_item_repository'

class InvoiceItemLoaderTest < Minitest::Test

  def test_loading_items_manually
    invoice_item_repository = InvoiceItemRepository.new
    invoice_item_repository.invoice_item_loader.add_invoice_item("id",
                                   "item_id",
                                   "invoice_id",
                                   "quantity",
                                   "unit_price",
                                   "created_at",
                                   "updated_at")
    assert invoice_item_repository.invoice_items["id"]
  end

  def test_returning_invoice_id_from_items_hash
    invoice_item_repository = InvoiceItemRepository.new
    invoice_item_loader = invoice_item_repository.invoice_item_loader
    invoice_item_loader.add_invoice_item("id",
                                   "item_id",
                                   "invoice_id",
                                   "quantity",
                                   "unit_price",
                                   "created_at",
                                   "updated_at")
    result = invoice_item_loader.invoice_item_repository.invoice_items["id"].invoice_id
    assert_equal "invoice_id", result
  end

  def test_that_csv_values_are_imported_from_fixture_file
    invoice_item_repository = InvoiceItemRepository.new('./fixtures/invoice_items.csv')
    assert_equal invoice_item_repository.invoice_items,
    invoice_item_repository.invoice_item_loader.load_invoice_items
  end

  def test_accessing_fixture_values
    invoice_item_repository = InvoiceItemRepository.new('./fixtures/invoice_items.csv')
    invoice_item_repository.invoice_item_loader.load_invoice_items
    assert_equal "7", invoice_item_repository.invoice_items["98"].quantity
  end

  def test_that_csv_values_are_imported_from_real_csv_file
    invoice_item_repository = InvoiceItemRepository.new
    assert_equal invoice_item_repository.invoice_items,
    invoice_item_repository.invoice_item_loader.load_invoice_items
  end

  def test_accessing_values_from_full_csv_file
    invoice_item_repository = InvoiceItemRepository.new
    invoice_item_repository.invoice_item_loader.load_invoice_items
    assert_equal "25", invoice_item_repository.invoice_items["120"].invoice_id
  end

end
