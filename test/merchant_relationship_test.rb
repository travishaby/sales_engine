require_relative 'test_helper'
require './lib/merchant'
require './lib/sales_engine'
require './lib/merchant_repository'

class MerchantRelationshipsTest < Minitest::Test

  # def setup
  #   sales_engine = SalesEngine.new
  #   merchant_repository = MerchantRepository.new(sales_engine)
  #   merchant_loader = MerchantLoader.new(merchant_repository, './fixtures/merchants.csv')
  #   item_repository = ItemRepository.new(sales_engine)
  #   item_loader = ItemLoader.new(item_repository, './fixtures/items.csv')
  #   # require 'pry'; binding.pry
  #   merchant_repository
  # end

  def setup
    sales_engine = SalesEngine.new
    sales_engine.fixture_startup
    sales_engine.merchant_repository
  end

  def test_gets_items_with_merchant_id
    result = setup.find_by_name("Williamson Group")[1].items.size
    assert_equal 9, result
  end

  def test_gets_invoices_with_merchant_id
    result = setup.find_by_name("Rutherford, Bogan and Leannon")[1].invoices.size
    assert_equal 2, result
  end

  end
