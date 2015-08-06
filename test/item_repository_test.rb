require_relative 'test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def data_setup
    item_repository = ItemRepository.new
    item_repository.item_loader.load_items
    item_repository
  end

  def fixture_setup
    item_repository = ItemRepository.new(nil, './fixtures/items.csv')
    item_repository.item_loader.load_items
    item_repository
  end

  def test_repo_starts_as_empty_hash
    item_repository = ItemRepository.new
    assert item_repository.items
  end

  def test_item_loader_object_is_created
    item_repository = ItemRepository.new
    assert item_repository.item_loader
  end

  def test_self_is_passed_into_item_loader
    item_repository = ItemRepository.new
    item_loader = item_repository.item_loader
    assert_equal item_repository, item_loader.item_repository
  end

  def test_accesses_item_name_with_merchant_id
    assert_equal "Item Rerum Est", data_setup.items["1"].name
  end

  def test_accesses_item_id_with_merchant_id
    assert_equal "2", data_setup.items["2"].merchant_id
  end

  def test_accesses_item_created_at_with_merchant_id
    assert_equal "2012-03-27 14:53:59 UTC",
    data_setup.items["3"].created_at
  end

  def test_accesses_item_updated_at_with_merchant_id
    assert_equal "2012-03-27 14:53:59 UTC",
    data_setup.items["4"].updated_at
  end

  def test_attempt_access_nonexistent_value
    refute data_setup.items["1001"]
  end

end
