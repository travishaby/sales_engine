require_relative 'test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def data_setup
    invoice_repository = InvoiceRepository.new
    invoice_repository.invoice_loader.load_invoices
    invoice_repository
  end

  def fixture_setup
    invoice_repository = InvoiceRepository.new(nil, './fixtures/invoices.csv')
    invoice_repository.invoice_loader.load_invoices
    invoice_repository
  end

  def test_repo_starts_as_empty_hash
    invoice_repository = InvoiceRepository.new
    assert invoice_repository.invoices
  end

  def test_invoice_loader_object_is_created
    invoice_repository = InvoiceRepository.new
    assert invoice_repository.invoice_loader
  end

  def test_self_is_passed_into_invoice_loader
    invoice_repository = InvoiceRepository.new
    invoice_loader = invoice_repository.invoice_loader
    assert_equal invoice_repository, invoice_loader.invoice_repository
  end

  def test_accesses_customer_id_with_id
    assert_equal "1", data_setup.invoices["1"].customer_id
  end

  def test_accesses_merchant_id_with_id
    assert_equal "75", data_setup.invoices["2"].merchant_id
  end

  def test_accesses_status_with_id
    assert_equal "shipped",
    data_setup.invoices["3"].status
  end

  def test_accesses_invoice_created_at_with_id
    assert_equal "2012-03-24 15:54:10 UTC",
    data_setup.invoices["4"].created_at
  end

  def test_accesses_invoice_updated_at_with_id
    assert_equal "2012-03-24 15:54:10 UTC",
    data_setup.invoices["4"].updated_at
  end

  def test_attempt_access_nonexistent_value
    refute data_setup.invoices["5000"]
  end

end
