require_relative 'test_helper'
require './lib/merchant_repository'
require './test/merchant_test'

class MerchantRepositoryTest < Minitest::Test

  def test_repo_starts_as_empty_hash
    merchant_repository = MerchantRepository.new
    assert merchant_repository.merchants
  end

  def test_merchant_loader_object_is_created
    merchant_repository = MerchantRepository.new
    assert merchant_repository.merchant_loader
  end

  def test_self_is_passed_into_merchant_loader
    merchant_repository = MerchantRepository.new
    merchant_loader = merchant_repository.merchant_loader
    assert_equal merchant_repository, merchant_loader.merchant_repository
  end

  def test_accesses_merchant_name_with_id
    merchant_repository = MerchantRepository.new
    merchant_repository.merchant_loader.load_merchants
    assert_equal "Schroeder-Jerde", merchant_repository.merchants["1"].name
  end

  def test_accesses_merchant_id_with_id
    merchant_repository = MerchantRepository.new
    merchant_repository.merchant_loader.load_merchants
    assert_equal "2", merchant_repository.merchants["2"].id
  end

  def test_accesses_merchant_created_at_with_id
    merchant_repository = MerchantRepository.new
    merchant_repository.merchant_loader.load_merchants
    assert_equal "2012-03-27 14:53:59 UTC",
    merchant_repository.merchants["3"].created_at
  end

  def test_accesses_merchant_updated_at_with_id
    merchant_repository = MerchantRepository.new
    merchant_repository.merchant_loader.load_merchants
    assert_equal "2012-03-27 14:53:59 UTC",
    merchant_repository.merchants["4"].updated_at
  end

  def test_attempt_access_nonexistent_value
    merchant_repository = MerchantRepository.new
    merchant_repository.merchant_loader.load_merchants
    refute merchant_repository.merchants["1001"]
  end

end
