require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_loader'
require './lib/item_repository'
require './test/item_repository_test'

class ItemLoaderTest < Minitest::Test

  def test_loading_items_manually
    item_repository = ItemRepository.new
    item_repository.item_loader.add_item("1", "name", "created_at", "updated_at")
    assert item_repository.items["1"]
  end

  def test_returning_name_from_items_hash
    item_repository = ItemRepository.new
    item_loader = item_repository.item_loader
    item_loader.add_item("1", "name1", "created_at", "updated_at")
    result = item_loader.item_repository.items["1"].name
    assert_equal "name1", result
  end

  def test_that_csv_values_are_imported_from_file
    item_repository = ItemRepository.new
    assert_equal item_repository.items,
    item_repository.item_loader.load_items
  end

end
