equire_relative 'test_helper'
require './lib/merchant'
require './lib/sales_engine'
require './lib/merchant_repository'

class MerchantRelationshipsTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.new

    merchant_repository = MerchantRepository.new(sales_engine, './fixtures/merchants.csv')
    merchant_repository.merchant_loader
    sales_engine.merchant_repository
  end

  def test_gets_items_with_merchant_id
    result = setup.find_by_name("Williamson Group")[1].items.size
    assert_equal 11, result
  end

  def test_case_name

  end

  end
