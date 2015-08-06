require_relative 'test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def data_setup
    merchant_repository = MerchantRepository.new
    merchant_repository.merchant_loader.load_merchants
    merchant_repository
  end

  def fixture_setup
    merchant_repository = MerchantRepository.new(nil, './fixtures/merchants.csv')
    merchant_repository.merchant_loader.load_merchants
    merchant_repository
  end

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
    assert_equal "Schroeder-Jerde", data_setup.merchants["1"].name
  end

  def test_accesses_merchant_id_with_id
    assert_equal "2", data_setup.merchants["2"].id
  end

  def test_accesses_merchant_created_at_with_id
    assert_equal "2012-03-27 14:53:59 UTC",
    data_setup.merchants["3"].created_at
  end

  def test_accesses_merchant_updated_at_with_id
    assert_equal "2012-03-27 14:53:59 UTC",
    data_setup.merchants["4"].updated_at
  end

  def test_attempt_access_nonexistent_value
    refute data_setup.merchants["1001"]
  end

end
