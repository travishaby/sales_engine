require_relative 'transaction'
require_relative 'transaction_loader'

class TransactionRepository

  attr_reader :transactions, :transaction_file, :engine

  def initialize(engine = nil, transaction_file = './data/transactions.csv')
    @transactions = {}
    @transaction_file = transaction_file
    @engine = engine
  end

  def transaction_loader
    TransactionLoader.new(self)
  end

end
