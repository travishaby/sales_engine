require_relative 'test_helper'
require './lib/item_loader'
require './lib/item_repository'

class ItemLoaderTest < Minitest::Test

  def test_loading_items_manually
    item_repository = ItemRepository.new
    item_repository.item_loader.add_item("id",
                                        "name",
                                         "description", "unit_price", "merchant_id", "created_at", "updated_at")
    assert item_repository.items["id"]
  end

  def test_returning_name_from_items_hash
    item_repository = ItemRepository.new
    item_loader = item_repository.item_loader
    item_loader.add_item("id",
                          "name1",
                         "description",
                          "unit_price",
                          "merchant_id",
                          "created_at",
                          "updated_at")
    result = item_loader.item_repository.items["id"].name
    assert_equal "name1", result
  end

  def test_that_csv_values_are_imported_from_fixture_file
    item_repository = ItemRepository.new('./fixtures/items.csv')
    assert_equal item_repository.items,
    item_repository.item_loader.load_items
  end

  def test_accessing_fixture_values
    item_repository = ItemRepository.new('./fixtures/items.csv')
    item_repository.item_loader.load_items
    assert_equal "Item Autem Minima", item_repository.items["2"].name
  end

  def test_that_csv_values_are_imported_from_real_csv_file
    item_repository = ItemRepository.new
    assert_equal item_repository.items,
    item_repository.item_loader.load_items
  end

  def test_accessing_values_from_full_csv_file
    item_repository = ItemRepository.new
    item_repository.item_loader.load_items
    assert_equal "Item Et Deleniti", item_repository.items["47"].name
  end

end
