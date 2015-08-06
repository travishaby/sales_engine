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

  def test_that_csv_values_are_imported_from_fixture_file
    transaction_repository = TransactionRepository.new('./fixtures/transactions.csv')
    assert_equal transaction_repository.transactions,
    transaction_repository.transaction_loader.load_transactions
  end

  def test_accessing_fixture_values
    transaction_repository = TransactionRepository.new('./fixtures/transactions.csv')
    transaction_repository.transaction_loader.load_transactions
    assert_equal "89", transaction_repository.transactions["98"].invoice_id
  end

  def test_that_csv_values_are_imported_from_real_csv_file
    transaction_repository = TransactionRepository.new
    assert_equal transaction_repository.transactions,
    transaction_repository.transaction_loader.load_transactions
  end

  def test_accessing_values_from_full_csv_file
    transaction_repository = TransactionRepository.new
    transaction_repository.transaction_loader.load_transactions
    assert_equal "4620443924688732", transaction_repository.transactions["120"].credit_card_number
  end

end
