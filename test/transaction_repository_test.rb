require_relative 'test_helper'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def data_setup
    transaction_repository = TransactionRepository.new
    transaction_repository.transaction_loader.load_transactions
    transaction_repository
  end

  def fixture_setup
    transaction_repository = TransactionRepository.new(nil, './fixtures/transactions.csv')
    transaction_repository.transaction_loader.load_transactions
    transaction_repository
  end

  def test_repo_starts_as_empty_hash
    transaction_repository = TransactionRepository.new
    assert transaction_repository.transactions
  end

  def test_transaction_loader_object_is_created
    transaction_repository = TransactionRepository.new
    assert transaction_repository.transaction_loader
  end

  def test_self_is_passed_into_transaction_loader
    transaction_repository = TransactionRepository.new
    transaction_loader = transaction_repository.transaction_loader
    assert_equal transaction_repository, transaction_loader.transaction_repository
  end

  def test_accesses_transaction_id_with_id
    assert_equal "1", data_setup.transactions["1"].id
  end

  def test_accesses_transaction_invoice_id_with_id
    assert_equal "2", data_setup.transactions["2"].invoice_id
  end

  def test_accesses_transaction_credit_card_number_with_id
    assert_equal "4354495077693036", data_setup.transactions["3"].credit_card_number
  end

  def test_accesses_transaction_credit_card_expiration_date_with_id
    assert_equal nil, data_setup.transactions["4"].credit_card_expiration_date
  end

  def test_accesses_transaction_created_at_with_id
    assert_equal "2012-03-27 14:54:10 UTC",
    data_setup.transactions["5"].created_at
  end

  def test_accesses_transaction_updated_at_with_id
    assert_equal "2012-03-27 14:54:10 UTC",
    data_setup.transactions["6"].updated_at
  end

  def test_attempt_access_nonexistent_value
    refute data_setup.transactions["5600"]
  end

end
