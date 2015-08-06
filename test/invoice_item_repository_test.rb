require_relative 'test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def data_setup
    invoice_item_repository = InvoiceItemRepository.new
    invoice_item_repository.invoice_item_loader.load_invoice_items
    invoice_item_repository
  end

  def fixture_setup
    invoice_item_repository = InvoiceItemRepository.new(nil, './fixtures/customers.csv')
    invoice_item_repository.invoice_item_loader.load_invoice_items
    invoice_item_repository
  end

  def test_repo_starts_as_empty_hash
    invoice_item_repository = InvoiceItemRepository.new
    assert invoice_item_repository.invoice_items
  end

  def test_invoice_item_loader_object_is_created
    invoice_item_repository = InvoiceItemRepository.new
    assert invoice_item_repository.invoice_item_loader
  end

  def test_self_is_passed_into_invoice_item_loader
    invoice_item_repository = InvoiceItemRepository.new
    invoice_item_loader = invoice_item_repository.invoice_item_loader
    assert_equal invoice_item_repository, invoice_item_loader.invoice_item_repository
  end

  def test_accesses_invoice_item_name_with_id
    assert_equal "1", data_setup.invoice_items["1"].invoice_id
  end

  def test_accesses_invoice_id_with_id
    assert_equal "1", data_setup.invoice_items["2"].invoice_id
  end

  def test_accesses_invoice_item_created_at_with_merchant_id
    assert_equal "2012-03-27 14:54:09 UTC",
    data_setup.invoice_items["3"].created_at
  end

  def test_accesses_invoice_item_updated_at_with_merchant_id
    assert_equal "2012-03-27 14:54:09 UTC",
    data_setup.invoice_items["4"].updated_at
  end

  def test_attempt_access_nonexistent_value
    refute data_setup.invoice_items["22000"]
  end

end
