require_relative 'test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def data_setup
    invoice_repository = InvoiceRepository.new
    invoice_loader = InvoiceLoader.new(invoice_repository)
    invoice_repository
  end

  def fixture_setup
    invoice_repository = InvoiceRepository.new
    invoice_loader = InvoiceLoader.new(invoice_repository, './fixtures/invoices.csv')
    invoice_repository
  end

  def test_repo_starts_as_empty_hash
    invoice_repository = InvoiceRepository.new
    assert invoice_repository.invoices
  end

  def test_accesses_customer_id_with_id
    assert_equal "1", fixture_setup.invoices["1"].customer_id
  end

  def test_accesses_merchant_id_with_id
    assert_equal "75", fixture_setup.invoices["2"].merchant_id
  end

  def test_accesses_status_with_id
    assert_equal "shipped",
    fixture_setup.invoices["3"].status
  end

  def test_accesses_invoice_created_at_with_id
    assert_equal "2012-03-24 15:54:10 UTC",
    fixture_setup.invoices["4"].created_at
  end

  def test_accesses_invoice_updated_at_with_id
    assert_equal "2012-03-24 15:54:10 UTC",
    fixture_setup.invoices["4"].updated_at
  end

  def test_attempt_access_nonexistent_value
    refute fixture_setup.invoices["5000"]
  end

  def test_that_all_returns_all_instances
    assert_equal 99, fixture_setup.all.size
  end

  def test_random_usually_returns_different_invoice
    invoice1 = fixture_setup.random
    invoice2 = fixture_setup.random
    5.times do
      assert invoice1 != invoice2
      invoice2 = fixture_setup.random
    end
  end

  def test_general_find_by_method_with_updated_at
    assert_equal "2012-03-12 05:54:09 UTC",
    fixture_setup.find_by(:updated_at,"2012-03-12 05:54:09 UTC")[1].updated_at
  end

  def test_returns_single_object_with_matching_id
    assert_equal "1", fixture_setup.find_by_id("5")[1].customer_id
  end

  def test_returns_single_object_with_matching_merchant_id
    assert_equal "27", fixture_setup.find_by_merchant_id("27")[1].merchant_id
  end

  def test_returns_single_object_with_matching_created_at
    assert_equal "2012-03-07 19:54:10 UTC",
    fixture_setup.find_by_created_at("2012-03-07 19:54:10 UTC")[1].created_at
  end

  def test_returns_single_object_with_matching_updated_at
    assert_equal "2012-03-26 07:54:10 UTC",
    fixture_setup.find_by_updated_at("2012-03-26 07:54:10 UTC")[1].updated_at
  end

  def test_general_find_by_all_method_with_customer_id_and_specific_keys
    assert_equal ["14", "15", "16", "17", "18", "19", "20", "21"],
    fixture_setup.find_by_all(:customer_id, "4").keys
  end

  def test_general_find_by_all_method_with_merchant_id
    assert_equal 1,
    fixture_setup.find_by_all(:merchant_id, "53").size
  end

  def test_general_find_by_all_returns_empty_array_if_name_not_found
    assert_equal [],
    fixture_setup.find_by_all(:merchant_id,"10000").keys
  end

  def test_find_all_by_id
    assert_equal 1, fixture_setup.find_all_by_id("76").size
  end

  def test_find_all_by_customer_id
    assert_equal 0, fixture_setup.find_all_by_customer_id("6").size
  end

  def test_find_all_by_first_name_with_specific_keys
    assert_equal ["32"], fixture_setup.find_all_by_merchant_id("85").keys
  end

  def test_find_all_by_created_at
    assert_equal 1, fixture_setup.find_all_by_created_at("2012-03-07 19:54:10 UTC").size
  end

  def test_find_all_by_updated_at
    assert_equal 1, fixture_setup.find_all_by_updated_at("2012-03-08 20:54:10 UTC").size
  end

end
