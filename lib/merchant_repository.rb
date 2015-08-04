require_relative 'merchant'
require_relative 'merchant_loader'

class MerchantRepository

  attr_reader :merchants

  def initialize
    @merchants = {}
  end

  def merchant_loader
    MerchantLoader.new(self)
  end

end
