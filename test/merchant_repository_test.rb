gem 'simplecov', :require => false, :group => :test
require 'simplecov'
SimpleCov.start

require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_repo_starts_as_empty_hash
    merchant_repo = MerchantRepository.new
    assert merchant_repo.merchants
  end


  def test_accessing_merchant_name_with_id
    merchant_repo = MerchantRepository.new
    merchant_repo.load_merchants
    assert_equal :"Schroeder-Jerde", merchant_repo.merchants["1"].name
  end

end
