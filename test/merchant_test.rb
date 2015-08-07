require_relative 'test_helper'
require './lib/merchant'
require './lib/sales_engine'
require './lib/merchant_repository'

class MerchantTest < Minitest::Test

  def test_it_initializes_with_correctly_formatted_values
    merchant = Merchant.new("1", "\"Schroeder-Jerde\"", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
    assert merchant.id
    assert merchant.name
    assert merchant.created_at
    assert merchant.updated_at
  end

  def test_it_initializes_with_incorrectly_formatted_name
    merchant = Merchant.new("1", "\"Schroeder-Jerde\"", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
    assert merchant.id
    assert merchant.name
    assert merchant.created_at
    assert merchant.updated_at
  end

  def test_fixtures_setup
    skip
    sales_engine = SalesEngine.new
    sales_engine.startup
    sales_engine.merchant_repository.merchant_loader.load_merchants
    sales_engine.merchant_repository
  end

  def test_gets_items_with_merchant_id
    skip
    result = test_fixtures_setup.find_by_name("Williamson Group")[1].items

    assert_equal "something", result
  end

  #get_items should ask merch repo to get from SE who will go to item repo
  #who will then use a find by method w/ the merchant id

end
