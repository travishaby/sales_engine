require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './test/merchant_test'

class MerchantRepositoryTest < Minitest::Test

  def test_repo_starts_as_empty_hash
    merchant_repository = MerchantRepository.new
    assert merchant_repository.merchants
  end

  def test_accessing_merchant_name_with_id
    merchant_repository = MerchantRepository.new
    merchant_repository.merchant_loader.load_merchants
    assert_equal :"Schroeder-Jerde", merchant_repository.merchants["1"].name
  end

end
