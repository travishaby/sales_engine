require './lib/merchant'
require_relative 'test_helper'

class MerchantTest < Minitest::Test

  def test_it_initializes_with_correctly_formatted_values
    merchant = Merchant.new("1", "\"Schroeder-Jerde\"", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
    assert merchant.id
    assert merchant.name
    assert merchant.created_at
    assert merchant.updated_at
  end

  def test_it_initializes_with_incorrectly_formatted_name
    merchant = Merchant.new("1", "\"Schroeder-Jerde\"", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
    assert merchant.id
    assert merchant.name
    assert merchant.created_at
    assert merchant.updated_at
  end

end
