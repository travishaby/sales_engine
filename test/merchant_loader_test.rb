<<<<<<< HEAD
=======
gem 'simplecov', :require => false, :group => :test
require 'simplecov'
SimpleCov.start

>>>>>>> master
require_relative 'test_helper'
require './lib/merchant_loader'
require './lib/merchant_repository'

class MerchantLoaderTest < Minitest::Test

  def test_loading_merchants_manually
    merchant_repository = MerchantRepository.new
    merchant_repository.merchant_loader.add_merchant("1", "name", "created_at", "updated_at")
    assert merchant_repository.merchants["1"]
  end

  def test_returning_name_from_repository_hash
    merchant_repository = MerchantRepository.new
    merchant_loader = merchant_repository.merchant_loader
    merchant_loader.add_merchant("1", "name1", "created_at", "updated_at")
    result = merchant_loader.merchant_repository.merchants["1"].name
    assert_equal "name1", result
  end

  def test_accessing_fixture_values
    merchant_repository = MerchantRepository.new('./fixtures/merchants.csv')
    assert_equal merchant_repository.merchants,
    merchant_repository.merchant_loader.load_merchants
  end

  def test_that_csv_values_are_imported_from_real_csv_file
    merchant_repository = MerchantRepository.new
    assert_equal merchant_repository.merchants,
    merchant_repository.merchant_loader.load_merchants
  end

end
