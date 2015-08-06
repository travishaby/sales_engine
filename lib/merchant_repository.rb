require_relative 'merchant'
require_relative 'merchant_loader'

class MerchantRepository

  attr_reader :merchants, :merchant_file

  def initialize(merchant_file = './data/merchants.csv')
    @merchants = {}
    @merchant_file = merchant_file
  end

  def merchant_loader
    MerchantLoader.new(self)
  end

end
