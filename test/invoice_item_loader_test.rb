require_relative 'test_helper'
require './lib/invoice_item_loader'
require './lib/invoice_item_repository'

class InvoiceItemLoaderTest < Minitest::Test

  def fixture_setup
    invoice_item_repository = InvoiceItemRepository.new
    invoice_item_loader = InvoiceItemLoader.new(invoice_item_repository, './fixtures/invoice_items.csv')
    invoice_item_repository
  end

  def data_setup
    invoice_item_repository = InvoiceItemRepository.new
    invoice_item_loader = InvoiceItemLoader.new(invoice_item_repository)
    invoice_item_repository
  end

  def test_that_csv_values_are_imported_from_fixture_file
    assert fixture_setup.invoice_items
  end

  def test_accessing_fixture_values
    assert_equal 7, fixture_setup.invoice_items[98].quantity
  end

  def test_that_csv_values_are_imported_from_real_csv_file
    assert data_setup.invoice_items
  end

  def test_accessing_values_from_full_csv_file
    assert_equal 25, data_setup.invoice_items[120].invoice_id
  end

end
