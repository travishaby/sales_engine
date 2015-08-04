require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repository'
require './test/invoice_test'

class InvoiceRepositoryTest < Minitest::Test

  def test_repo_starts_as_empty_hash
    invoice_repository = InvoiceRepository.new
    assert invoice_repository.invoices
  end

  def test_merchant_loader_object_is_created
    invoice_repository = InvoiceRepository.new
    assert invoice_repository.merchant_loader
  end

  def test_self_is_passed_into_merchant_loader
    invoice_repository = InvoiceRepository.new
    merchant_loader = invoice_repository.merchant_loader
    assert_equal invoice_repository, merchant_loader.invoice_repository
  end

  def test_accesses_merchant_name_with_id
    invoice_repository = InvoiceRepository.new
    invoice_repository.merchant_loader.load_invoices
    assert_equal "Schroeder-Jerde", invoice_repository.invoices["1"].name
  end

  def test_accesses_merchant_id_with_id
    invoice_repository = InvoiceRepository.new
    invoice_repository.merchant_loader.load_invoices
    assert_equal "2", invoice_repository.invoices["2"].id
  end

  def test_accesses_merchant_created_at_with_id
    invoice_repository = InvoiceRepository.new
    invoice_repository.merchant_loader.load_invoices
    assert_equal "2012-03-27 14:53:59 UTC",
    invoice_repository.invoices["3"].created_at
  end

  def test_accesses_merchant_updated_at_with_id
    invoice_repository = InvoiceRepository.new
    invoice_repository.merchant_loader.load_invoices
    assert_equal "2012-03-27 14:53:59 UTC",
    invoice_repository.invoices["4"].updated_at
  end

  def test_attempt_access_nonexistent_value
    invoice_repository = InvoiceRepository.new
    invoice_repository.merchant_loader.load_invoices
    refute invoice_repository.invoices["1001"]
  end

end
