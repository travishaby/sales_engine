require_relative 'test_helper'
require './lib/item_loader'
require './lib/item_repository'

class ItemLoaderTest < Minitest::Test

  def fixture_setup
    item_repository = ItemRepository.new
    item_loader = ItemLoader.new(item_repository, './fixtures/items.csv')
    item_repository
  end

  def data_setup
    item_repository = ItemRepository.new
    item_loader = ItemLoader.new(item_repository)
    item_repository
  end

  def test_that_csv_values_are_imported_from_fixture_file
    assert fixture_setup.items
  end

  def test_accessing_fixture_values
    assert_equal "Item Autem Minima", fixture_setup.items[2].name
  end

  def test_that_csv_values_are_imported_from_real_csv_file
    assert data_setup.items
  end

  def test_accessing_values_from_full_csv_file
    assert_equal "Item Et Deleniti", data_setup.items[47].name
  end

end
