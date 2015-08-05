require_relative 'transaction'
require_relative 'transaction_loader'

class TransactionRepository

  attr_reader :transaction

  def initialize
    @transactions = {}
  end

  def transaction_loader
    TransactionLoader.new(self)
  end

end
