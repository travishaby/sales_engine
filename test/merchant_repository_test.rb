require_relative 'test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def data_setup
    merchant_repository = MerchantRepository.new
    merchant_loader = MerchantLoader.new(merchant_repository)
    merchant_repository
  end

  def fixture_setup
    merchant_repository = MerchantRepository.new
    merchant_loader = MerchantLoader.new(merchant_repository, './fixtures/merchants.csv')
    merchant_repository
  end

  def test_repo_starts_as_empty_hash
    merchant_repository = MerchantRepository.new
    assert merchant_repository.merchants
  end

  def test_accesses_merchant_name_with_id
    assert_equal "Schroeder-Jerde", fixture_setup.merchants[1].name
  end

  def test_accesses_merchant_id_with_id
    assert_equal 2, fixture_setup.merchants[2].id
  end

  def test_accesses_merchant_created_at_with_id
    assert_equal "2012-03-27 14:53:59 UTC",
    fixture_setup.merchants[3].created_at
  end

  def test_accesses_merchant_updated_at_with_id
    assert_equal "2012-03-27 14:53:59 UTC",
    fixture_setup.merchants[4].updated_at
  end

  def test_attempt_access_nonexistent_value
    refute fixture_setup.merchants[1001]
  end


  def test_that_all_returns_all_instances
    assert_equal 100, fixture_setup.all.size
  end

  def test_random_usually_returns_different_merchant
    merch1 = fixture_setup.random
    merch2 = fixture_setup.random
    5.times do
      assert merch1 != merch2
      merch2 = fixture_setup.random
    end
  end

  def test_general_find_by_method_with_updated_at
    assert_equal "2012-03-27 14:54:09 UTC",
    fixture_setup.find_by(:updated_at,"2012-03-27 14:54:09 UTC").updated_at
  end

  def test_returns_single_object_with_matching_id
    assert_equal "Fahey-Stiedemann", fixture_setup.find_by_id(99).name
  end

  def test_returns_single_object_with_matching_name
    assert_equal "Fahey-Stiedemann", fixture_setup.find_by_name("Fahey-Stiedemann").name
  end

  def test_returns_single_object_with_matching_created_at
    assert_equal "2012-03-27 14:54:00 UTC",
    fixture_setup.find_by_created_at("2012-03-27 14:54:00 UTC").created_at
  end

  def test_returns_single_object_with_matching_updated_at
    assert_equal "2012-03-27 14:54:00 UTC",
    fixture_setup.find_by_updated_at("2012-03-27 14:54:00 UTC").updated_at
  end

  def test_general_find_by_all_method_with_name_and_specific_keys
    assert_equal [5, 6],
    fixture_setup.find_by_all(:name,"Williamson Group").keys
  end

  def test_general_find_by_all_method_with_name
    assert_equal 2,
    fixture_setup.find_by_all(:name,"Williamson Group").size
  end

  def test_general_find_by_all_returns_empty_array_if_name_not_found
    assert_equal [],
    fixture_setup.find_by_all(:name,"Burch").keys
  end

  def test_general_find_by_all_returns_array_size_zero_if_name_not_found
    assert_equal 0,
    fixture_setup.find_by_all(:name,"Burch").size
  end

  def test_find_all_by_id
    assert_equal 1, fixture_setup.find_all_by_id(76).size
  end

  def test_find_all_by_name
    assert_equal 2, fixture_setup.find_all_by_name("Williamson Group").size
  end

  def test_find_all_by_name_with_specific_keys
    assert_equal [5, 6], fixture_setup.find_all_by_name("Williamson Group").keys
  end

  def test_find_all_by_created_at
    assert_equal 9, fixture_setup.find_all_by_created_at("2012-03-27 14:53:59 UTC").size
  end

  def test_find_all_by_updated_at
    assert_equal 8, fixture_setup.find_all_by_updated_at("2012-03-27 14:53:59 UTC").size
  end

end
