gem 'simplecov', :require => false, :group => :test
require 'simplecov'
SimpleCov.start

require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_loader'
require './lib/merchant_repository'

class MerchantLoaderTest < Minitest::Test

  def test_loading_merchants_manually
    skip
    merchant_loader = MerchantLoader.new
    merch1 = Merchant.new("1", "name", "created_at", "updated_at")
    assert_equal merch1,
    merchant_loader.add_merchant("1", merch1)
  end

  def test_returning_expected_hash_after_adding_merchants
    merchant_repository = MerchantRepository.new
    merchant_loader = merchant_repository.load_merchants
    merchant_loader.add_merchant("1", "name1", "created_at", "updated_at")
    merchant_loader.add_merchant("2", "name2", "created_at", "updated_at")
    result = merchant_loader.merchant_repository.merchants["1"].name
    assert_equal :name1, result
  end

  def test_that_csv_values_are_imported_from_file
    skip
    merchant_loader = MerchantLoader.new
    assert_equal merchant_loader.merchants, merchant_loader.load_merchants
  end

end
