require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_initializes_with_given_values
    merchant = Merchant.new("1", "Schroeder-Jerde", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
    assert merchant.id
    assert merchant.name
    assert merchant.created_at
    assert merchant.updated_at
  end

end
