require_relative 'test_helper'
require './lib/customer_loader'
require './lib/customer_repository'

class CustomerLoaderTest < Minitest::Test

  def fixture_setup
    customer_repository = CustomerRepository.new
    customer_loader = CustomerLoader.new(customer_repository, './fixtures/customers.csv')
    customer_repository
  end

  def data_setup
    customer_repository = CustomerRepository.new
    customer_loader = CustomerLoader.new(customer_repository)
    customer_repository
  end

  def test_that_csv_values_are_imported_from_fixture_file
    assert fixture_setup.customers
  end

  def test_accessing_fixture_values
    assert_equal "Quinton", fixture_setup.customers[98].first_name
  end

  def test_that_csv_values_are_imported_from_real_csv_file
    assert data_setup.customers
  end

  def test_accessing_values_from_full_csv_file
    assert_equal "Samanta", data_setup.customers[120].first_name
  end

end
