require_relative 'test_helper'
require './lib/transaction_loader'
require './lib/transaction_repository'

class TransactionLoaderTest < Minitest::Test

  def fixture_setup
    transaction_repository = TransactionRepository.new
    transaction_loader = TransactionLoader.new(transaction_repository, './fixtures/transactions.csv')
    transaction_repository
  end

  def data_setup
    transaction_repository = TransactionRepository.new
    transaction_loader = TransactionLoader.new(transaction_repository)
    transaction_repository
  end

  def test_that_csv_values_are_imported_from_fixture_file
    assert fixture_setup.transactions
  end

  def test_accessing_fixture_values
    assert_equal "89", fixture_setup.transactions["98"].invoice_id
  end

  def test_that_csv_values_are_imported_from_real_csv_file
    assert data_setup.transactions
  end

  def test_accessing_values_from_full_csv_file
    assert_equal "4620443924688732", data_setup.transactions["120"].credit_card_number
  end

end
