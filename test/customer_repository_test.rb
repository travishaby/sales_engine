require_relative 'test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def data_setup
    customer_repository = CustomerRepository.new
    customer_loader = CustomerLoader.new(customer_repository)
    customer_repository
  end

  def fixture_setup
    customer_repository = CustomerRepository.new
    customer_loader = CustomerLoader.new(customer_repository, './fixtures/customers.csv')
    customer_repository
  end

  def test_repo_starts_as_empty_hash
    customer_repository = CustomerRepository.new
    assert customer_repository.customers
  end

  def test_accesses_customer_first_name_with_id
    assert_equal "Joey", fixture_setup.customers["1"].first_name
  end

  def test_accesses_customer_last_name_with_id
    assert_equal "Ondricka", fixture_setup.customers["1"].last_name
  end

  def test_accesses_customer_id_with_id
    assert_equal "2", fixture_setup.customers["2"].id
  end

  def test_accesses_customer_created_at_with_id
    assert_equal "2012-03-27 14:54:10 UTC",
    fixture_setup.customers["3"].created_at
  end

  def test_accesses_customer_updated_at_with_id
    assert_equal "2012-03-27 14:54:10 UTC",
    fixture_setup.customers["4"].updated_at
  end

  def test_attempt_access_nonexistent_value
    refute fixture_setup.customers["103"]
  end

  def test_that_all_returns_all_instances
    assert_equal 101, fixture_setup.all.size
  end

  def test_random_usually_returns_different_customer
    cust1 = fixture_setup.random
    cust2 = fixture_setup.random
    5.times do
      assert cust1 != cust2
      cust2 = fixture_setup.random
    end
  end

  def test_general_find_by_method_with_updated_at
    assert_equal "2012-03-27 14:54:32 UTC",
    fixture_setup.find_by(:updated_at,"2012-03-27 14:54:32 UTC").updated_at
  end

  def test_returns_single_object_with_matching_id
    assert_equal "Sylvester", fixture_setup.find_by_id("5").first_name
  end

  def test_returns_single_object_with_matching_first_name
    assert_equal "Magnus", fixture_setup.find_by_first_name("Magnus").first_name
  end

  def test_returns_single_object_with_case_insensitive_first_name
    assert_equal "Magnus", fixture_setup.find_by_first_name("magnus").first_name
  end

  def test_returns_single_object_with_extra_name
    assert_equal [], fixture_setup.find_by_first_name("Mary")
  end

  def test_returns_single_object_with_matching_last_name
    assert_equal "Barrows", fixture_setup.find_by_last_name("Barrows").last_name
  end

  def test_returns_single_object_with_matching_created_at
    assert_equal "2012-03-27 14:54:32 UTC",
    fixture_setup.find_by_created_at("2012-03-27 14:54:32 UTC").created_at
  end

  def test_returns_single_object_with_matching_updated_at
    assert_equal "2012-03-27 14:54:32 UTC",
    fixture_setup.find_by_updated_at("2012-03-27 14:54:32 UTC").updated_at
  end

  def test_general_find_by_all_method_with_last_name_and_specific_keys
    assert_equal ["91", "100"],
    fixture_setup.find_by_all(:last_name,"Barrows").keys
  end

  def test_general_find_by_all_method_with_last_name
    assert_equal 2,
    fixture_setup.find_by_all(:last_name,"Barrows").size
  end

  def test_general_find_by_all_returns_empty_array_if_name_not_found
    assert_equal [],
    fixture_setup.find_by_all(:last_name,"Burch").keys
  end

  def test_general_find_by_all_returns_array_size_zero_if_name_not_found
    assert_equal 0,
    fixture_setup.find_by_all(:last_name,"Burch").size
  end

  def test_find_all_by_id
    assert_equal 1, fixture_setup.find_all_by_id("76").size
  end

  def test_find_all_by_first_name
    assert_equal 1, fixture_setup.find_all_by_first_name("Wayne").size
  end

  def test_find_all_by_first_name_with_specific_keys
    assert_equal ["47"], fixture_setup.find_all_by_first_name("Wayne").keys
  end

  def test_find_all_by_first_name_case_insensitive
    assert_equal ["47"], fixture_setup.find_all_by_first_name("wayne").keys
  end

  def test_find_all_by_last_name
    assert_equal 2, fixture_setup.find_all_by_last_name("Barrows").size
  end

  def test_find_all_by_last_name_with_specific_keys
    assert_equal ["91", "100"], fixture_setup.find_all_by_last_name("Barrows").keys
  end

  def test_find_all_by_created_at
    assert_equal 3, fixture_setup.find_all_by_created_at("2012-03-27 14:54:11 UTC").size
  end

  def test_find_all_by_updated_at
    assert_equal 4, fixture_setup.find_all_by_updated_at("2012-03-27 14:54:13 UTC").size
  end

end
