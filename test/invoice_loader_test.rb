require_relative 'test_helper'
require './lib/invoice_loader'
require './lib/invoice_repository'

class InvoiceLoaderTest < Minitest::Test

  def test_loading_invoices_manually
    invoice_repository = InvoiceRepository.new
    invoice_repository.invoice_loader.add_invoice("1",
                                                    "1",
                                                    "26",
                                                    "shipped",
                                                    "2012-03-25 09:54:09 UTC",
                                                    "2012-03-25 09:54:09 UTC")
    assert invoice_repository.invoices["1"]
  end

  def test_returning_name_from_repository_hash
    invoice_repository = InvoiceRepository.new
    invoice_loader = invoice_repository.invoice_loader
    invoice_loader.add_invoice("1",
                              "1",
                              "26",
                              "shipped",
                              "2012-03-25 09:54:09 UTC",
                              "2012-03-25 09:54:09 UTC")
    result = invoice_loader.invoice_repository.invoices["1"].customer_id
    assert_equal "1", result
  end

  def test_that_csv_values_are_imported_from_file
    invoice_repository = InvoiceRepository.new
    assert_equal invoice_repository.invoices,
    invoice_repository.invoice_loader.load_invoices
  end

end
