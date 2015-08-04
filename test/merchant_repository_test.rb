gem 'simplecov', :require => false, :group => :test
require 'simplecov'
SimpleCov.start

require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_repo_starts_as_empty_hash
    merchant_repo = MerchantRepository.new
    assert merchant_repo.merchants
  end

  def test_loading_merchants_manually
    skip
    merchant_repo = MerchantRepository.new
    values = ["merchant name", "created_at", "updated_at"]
    assert_equal values,
    merchant_repo.add_merchant("1", Merchant.new("id", "name", "created_at", "updated_at"))
  end

  def test_returning_expected_hash_after_adding_merchants
    merchant_repo = MerchantRepository.new
    values = ["merchant name", "created_at", "updated_at"]


    assert_equal values, merchant_repo.add_merchant("1", Merchant.new("1", "name", "created_at", "updated_at"))

    assert_equal values, merchant_repo.add_merchant("2", Merchant.new("id", "name", "created_at", "updated_at"))

    expected_hash = {"1"=>["merchant name", "created_at", "updated_at"],
    "2"=>["merchant name", "created_at", "updated_at"]}
    assert_equal expected_hash, merchant_repo.merchants
  end

  def test_that_csv_values_are_imported_from_file
    merchant_repo = MerchantRepository.new
    assert_equal merchant_repo.merchants, merchant_repo.load_merchants
  end

end
