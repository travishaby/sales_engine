require_relative 'test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def data_setup
    invoice_item_repository = InvoiceItemRepository.new
    invoice_item_loader = InvoiceItemLoader.new(invoice_item_repository)
    invoice_item_repository
  end

  def fixture_setup
    invoice_item_repository = InvoiceItemRepository.new
    invoice_item_loader = InvoiceItemLoader.new(invoice_item_repository, './fixtures/invoice_items.csv')
    invoice_item_repository
  end

  def test_repo_starts_as_empty_hash
    invoice_item_repository = InvoiceItemRepository.new
    assert invoice_item_repository.invoice_items
  end

  def test_accesses_invoice_id_with_id
    assert_equal "1", data_setup.invoice_items["2"].invoice_id
  end

  def test_accesses_invoice_item_created_at_with_id
    assert_equal "2012-03-27 14:54:09 UTC",
    data_setup.invoice_items["3"].created_at
  end

  def test_accesses_invoice_item_updated_at_with_id
    assert_equal "2012-03-27 14:54:09 UTC",
    data_setup.invoice_items["4"].updated_at
  end

  def test_attempt_access_nonexistent_value
    refute data_setup.invoice_items["22000"]
  end

  def test_that_all_returns_all_instances
    assert_equal 99, fixture_setup.all.size
  end

  def test_random_usually_returns_different_item_id
    item_id1 = fixture_setup.random
    item_id2 = fixture_setup.random
    5.times do
      assert item_id1 != item_id2
      item_id2 = fixture_setup.random
    end
  end

  def test_general_find_by_method_with_updated_at
    assert_equal "2012-03-27 14:54:09 UTC",
    fixture_setup.find_by(:updated_at,"2012-03-27 14:54:09 UTC")[1].updated_at
  end

  def test_returns_single_object_with_matching_item_id
    assert_equal "528", fixture_setup.find_by_item_id("528")[1].item_id
  end

  def test_returns_single_object_unit_price
    assert_equal "23324", fixture_setup.find_by_unit_price("23324")[1].unit_price
  end

  def test_general_find_by_all_method_with_unit_price
    assert_equal 4,
    fixture_setup.find_by_all(:unit_price,"85319").size
  end

  def test_general_find_by_all_returns_empty_array_if_item_id_not_found
    assert_equal [],
    fixture_setup.find_by_all(:item_id,"7300").keys
  end

  def test_general_find_by_all_returns_array_size_zero_if_item_not_found
    assert_equal 0,
    fixture_setup.find_by_all(:item_id,"7300").size
  end

  def test_find_all_by_quantity
    assert_equal 0, fixture_setup.find_all_by_quantity("13635").size
  end

  def test_find_all_by_first_name_with_specific_keys
    assert_equal ["7"], fixture_setup.find_all_by_item_id("530").keys
  end

  def test_find_all_by_created_at
    assert_equal 15, fixture_setup.find_all_by_created_at("2012-03-27 14:54:09 UTC").size
  end

end
