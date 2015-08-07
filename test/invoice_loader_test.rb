require_relative 'test_helper'
require './lib/invoice_loader'
require './lib/invoice_repository'

class InvoiceLoaderTest < Minitest::Test

  def fixture_setup
    invoice_repository = InvoiceRepository.new
    invoice_loader = InvoiceLoader.new(invoice_repository, './fixtures/invoices.csv')
    invoice_repository
  end

  def data_setup
    invoice_repository = InvoiceRepository.new
    invoice_loader = InvoiceLoader.new(invoice_repository)
    invoice_repository
  end

  def test_that_csv_values_are_imported_from_fixture_file
    assert fixture_setup.invoices
  end

  def test_accessing_fixture_values
    assert_equal "shipped",
    fixture_setup.invoices["2"].status
  end

  def test_that_csv_values_are_imported_from_real_csv_file
    assert data_setup.invoices
  end

  def test_accessing_values_from_full_csv_file
    assert_equal "2012-03-23 22:54:14 UTC", fixture_setup.invoices["95"].updated_at
  end

end
