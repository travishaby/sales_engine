require_relative 'test_helper'
require './lib/transaction_loader'
require './lib/transaction_repository'

class TransactionLoaderTest < Minitest::Test

  def test_loading_transactions_manually
    transaction_repository = TransactionRepository.new
    transaction_repository.transaction_loader.add_transaction("1",
                                                              "1",
                                                              "4654405418249632",
                                                              "",
                                                              "success",
                                                              "2012-03-27 14:54:09 UTC",
                                                              "2012-03-27 14:54:09 UTC")
    assert transaction_repository.transactions["1"]
  end

  def test_returning_credit_card_number_from_repository_hash
    transaction_repository = TransactionRepository.new
    transaction_loader = transaction_repository.transaction_loader
    transaction_loader.add_transaction("1",
                                       "1",
                                       "4654405418249632",
                                       "",
                                       "success",
                                       "2012-03-27 14:54:09 UTC",
                                       "2012-03-27 14:54:09 UTC")
    result = transaction_loader.transaction_repository.transactions["1"].credit_card_number
    assert_equal "4654405418249632", result
  end

  def test_that_csv_values_are_imported_from_file
    transaction_repository = TransactionRepository.new
    results = transaction_repository.transaction_loader.load_transactions
    assert_equal transaction_repository.transactions, result
  end

end
