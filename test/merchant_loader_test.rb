require_relative 'test_helper'
require './lib/merchant_loader'
require './lib/merchant_repository'

class MerchantLoaderTest < Minitest::Test

  def test_accessing_fixture_values
    merchant_repository = MerchantRepository.new
    merchant_loader = MerchantLoader.new(merchant_repository, './fixtures/merchants.csv')
    assert_equal merchant_repository.merchants,
    merchant_loader.merchant_repository.merchants
  end

  def test_that_csv_values_are_imported_from_real_csv_file
    merchant_repository = MerchantRepository.new
    merchant_loader = MerchantLoader.new(merchant_repository)
    assert_equal merchant_repository.merchants,
    merchant_loader.merchant_repository.merchants
  end

end
