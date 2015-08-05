require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repository'
require './test/customer_test'

class CustomerRepositoryTest < Minitest::Test

  def test_repo_starts_as_empty_hash
    customer_repository = CustomerRepository.new
    assert customer_repository.customers
  end

  def test_customer_loader_object_is_created
    customer_repository = CustomerRepository.new
    assert customer_repository.customer_loader
  end

  def test_self_is_passed_into_customer_loader
    customer_repository = CustomerRepository.new
    customer_loader = customer_repository.customer_loader
    assert_equal customer_repository, customer_loader.customer_repository
  end

  def test_accesses_customer_first_name_with_id
    customer_repository = CustomerRepository.new
    customer_repository.customer_loader.load_customers
    assert_equal "Joey", customer_repository.customers["1"].first_name
  end

  def test_accesses_customer_last_name_with_id
    customer_repository = CustomerRepository.new
    customer_repository.customer_loader.load_customers
    assert_equal "Ondricka", customer_repository.customers["1"].last_name
  end

  def test_accesses_customer_id_with_id
    customer_repository = CustomerRepository.new
    customer_repository.customer_loader.load_customers
    assert_equal "2", customer_repository.customers["2"].id
  end

  def test_accesses_customer_created_at_with_id
    customer_repository = CustomerRepository.new
    customer_repository.customer_loader.load_customers
    assert_equal "2012-03-27 14:54:10 UTC",
    customer_repository.customers["3"].created_at
  end

  def test_accesses_customer_updated_at_with_id
    customer_repository = CustomerRepository.new
    customer_repository.customer_loader.load_customers
    assert_equal "2012-03-27 14:54:10 UTC",
    customer_repository.customers["4"].updated_at
  end

  def test_attempt_access_nonexistent_value
    customer_repository = CustomerRepository.new
    customer_repository.customer_loader.load_customers
    refute customer_repository.customers["1001"]
  end

end
