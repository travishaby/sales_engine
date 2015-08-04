require 'csv'
require './lib/merchant'

class MerchantRepository

  attr_reader :merchants

  def initialize
    @merchants = {}
  end

  def add_merchant(key, merchant)
    merchants[key] = merchant
  end

  def load_merchants
    CSV.foreach('./data/merchants.csv',
                headers: true,
                header_converters: :symbol) do |row|
      add_merchant(row[:id], Merchant.new(row[:id], row[:name], row[:created_at], row[:updated_at]))
    end
    merchants
  end

end
