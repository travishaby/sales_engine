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
    merchant_repo = MerchantRepository.new
    merch1 = Merchant.new("1", "name", "created_at", "updated_at")
    assert_equal merch1,
    merchant_repo.add_merchant("1", merch1)
  end

  def test_returning_expected_hash_after_adding_merchants
    merchant_repo = MerchantRepository.new
    merch1 = Merchant.new("1", "name", "created_at", "updated_at")
    merch2 = Merchant.new("id", "name", "created_at", "updated_at")
    assert_equal merch1, merchant_repo.add_merchant("1", merch1)
    assert_equal merch2, merchant_repo.add_merchant("2", merch2)
    expected_hash = {"1"=>merch1, "2"=>merch2}
    assert_equal expected_hash, merchant_repo.merchants
  end

  def test_that_csv_values_are_imported_from_file
    merchant_repo = MerchantRepository.new
    assert_equal merchant_repo.merchants, merchant_repo.load_merchants
  end

  def test_accessing_merchant_name_with_id
    merchant_repo = MerchantRepository.new
    merchant_repo.load_merchants
    assert_equal :"Schroeder-Jerde", merchant_repo.merchants["1"].name
  end

end
