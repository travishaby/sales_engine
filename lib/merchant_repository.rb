require 'csv'
require './lib/merchant'

class MerchantRepository

  attr_reader :merchants

  def initialize
    @merchants = {}
  end


  def load_merchants
    merchant_loader = MerchantLoader.new(self)
  end

end
