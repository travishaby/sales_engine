require 'csv'

class MerchantLoader

  attr_reader :merchant_repository,
  :merchant_file

  def initialize(merchant_repository, merchant_file = './data/merchants.csv')
    @merchant_repository = merchant_repository
    @merchant_file       = merchant_file
    self.load_merchants
  end

  def add_merchant(id, name, created_at, updated_at)
    merchant_repository.merchants[id] = Merchant.new(id, name, created_at, updated_at, merchant_repository)
  end

  def load_merchants
    CSV.foreach(merchant_file,
                headers: true,
                header_converters: :symbol) do |row|
      add_merchant(row[:id], row[:name], row[:created_at], row[:updated_at])
    end
    merchant_repository.merchants
  end

end
