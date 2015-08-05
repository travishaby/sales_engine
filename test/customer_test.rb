require_relative 'test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test

  def test_it_initializes_with_correctly_formatted_values
    customer = Customer.new("1",
                            "Joey",
                            "Ondricka",
                            "2012-03-27 14:54:09 UTC",
                            "2012-03-27 14:54:09 UTC")
    assert customer.id
    assert customer.first_name
    assert customer.last_name
    assert customer.created_at
    assert customer.updated_at
  end

  def test_it_initializes_with_incorrectly_formatted_name
    customer = Customer.new("1",
                            "Joey",
                            "Ondricka",
                            "2012-03-27 14:54:09 UTC",
                            "2012-03-27 14:54:09 UTC")
    assert customer.id
    assert customer.first_name
    assert customer.last_name
    assert customer.created_at
    assert customer.updated_at
  end

end
