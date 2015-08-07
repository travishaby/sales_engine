require_relative 'test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def data_setup
    item_repository = ItemRepository.new
    item_loader = ItemLoader.new(item_repository)
    item_repository
  end

  def fixture_setup
    item_repository = ItemRepository.new
    item_loader = ItemLoader.new(item_repository, './fixtures/items.csv')
    item_repository
  end

  def test_repo_starts_as_empty_hash
    item_repository = ItemRepository.new
    assert item_repository.items
  end

  def test_accesses_item_id_with_id
    assert_equal "2", fixture_setup.items["2"].id
  end

  def test_accesses_item_name_with_id
    assert_equal "Item Qui Esse", fixture_setup.items["1"].name
  end

  def test_accesses_item_created_at_with_id
    assert_equal "2012-03-27 14:53:59 UTC",
    fixture_setup.items["3"].created_at
  end

  def test_accesses_item_updated_at_with_id
    assert_equal "2012-03-27 14:53:59 UTC",
    fixture_setup.items["4"].updated_at
  end

  def test_attempt_access_nonexistent_value
    refute fixture_setup.items["10001"]
  end

  def test_that_all_returns_all_instances
    assert_equal 100, fixture_setup.all.size
  end

  def test_random_usually_returns_different_item
    item1 = fixture_setup.random
    item2 = fixture_setup.random
    5.times do
      assert item1 != item2
      item2 = fixture_setup.random
    end
  end

  def test_returns_single_object_with_matching_name
    assert_equal "Item Autem Minima", fixture_setup.find_by_name("Item Autem Minima")[1].name
  end

  def test_returns_single_object_with_matching_unit_price
    assert_equal "75107", fixture_setup.find_by_unit_price("75107")[1].unit_price
  end

  def test_returns_single_object_with_matching_created_at
    assert_equal "2012-03-27 14:53:59 UTC",
    fixture_setup.find_by_created_at("2012-03-27 14:53:59 UTC")[1].created_at
  end

  def test_returns_single_object_with_matching_updated_at
    assert_equal "2012-03-27 14:53:59 UTC",
    fixture_setup.find_by_updated_at("2012-03-27 14:53:59 UTC")[1].updated_at
  end

  def test_general_find_by_all_method_with_name_and_specific_keys
    assert_equal ["4"],
    fixture_setup.find_by_all(:name,"Item Nemo Facere").keys
  end

  def test_general_find_by_all_method_with_name
    assert_equal 1,
    fixture_setup.find_by_all(:name,"Item Nemo Facere").size
  end

  def test_general_find_by_all_returns_empty_array_if_name_not_found
    assert_equal [],
    fixture_setup.find_by_all(:name,"Burch").keys
  end

  def test_general_find_by_all_returns_array_size_zero_if_name_not_found
    assert_equal 0,
    fixture_setup.find_by_all(:name,"Burch").size
  end

  def test_find_all_by_id
    assert_equal 1, fixture_setup.find_all_by_id("76").size
  end

  def test_find_all_by_name
    assert_equal 1, fixture_setup.find_all_by_name("Item Expedita Aliquam").size
  end

  def test_find_all_by_name_with_specific_keys
    assert_equal ["5"], fixture_setup.find_all_by_name("Item Expedita Aliquam").keys
  end

  def test_find_all_by_merchant_id
    assert_equal 26, fixture_setup.find_all_by_merchant_id("3").size
  end

  def test_find_all_by_updated_at
    assert_equal 0, fixture_setup.find_all_by_updated_at("2012-03-27 14:54:13 UTC").size
  end

end
