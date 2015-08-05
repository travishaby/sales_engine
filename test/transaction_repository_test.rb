require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repository'
# require './test/transaction_test'

class TransactionRepositoryTest < Minitest::Test

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
    transaction_repository = TransactionRepository.new
    transaction_repository.transaction_loader.load_transactions
    assert_equal "1", transaction_repository.transactions["1"].id
  end

  def test_accesses_transaction_invoice_id_with_id
    transaction_repository = TransactionRepository.new
    transaction_repository.transaction_loader.load_transactions
    assert_equal "2", transaction_repository.transactions["2"].invoice_id
  end

  def test_accesses_transaction_credit_card_number_with_id
    transaction_repository = TransactionRepository.new
    transaction_repository.transaction_loader.load_transactions
    assert_equal "4354495077693036", transaction_repository.transactions["3"].credit_card_number
  end

  def test_accesses_transaction_credit_card_expiration_date_with_id
    transaction_repository = TransactionRepository.new
    transaction_repository.transaction_loader.load_transactions
    assert_equal "", transaction_repository.transactions["4"].credit_card_expiration_date
  end

  def test_accesses_transaction_created_at_with_id
    transaction_repository = TransactionRepository.new
    transaction_repository.transaction_loader.load_transactions
    assert_equal "2012-03-27 14:54:10 UTC",
    transaction_repository.transactions["5"].created_at
  end

  def test_accesses_transaction_updated_at_with_id
    transaction_repository = TransactionRepository.new
    transaction_repository.transaction_loader.load_transactions
    assert_equal "2012-03-27 14:54:10 UTC",
    transaction_repository.transactions["6"].updated_at
  end

  def test_attempt_access_nonexistent_value
    transaction_repository = TransactionRepository.new
    transaction_repository.transaction_loader.load_transactions
    refute transaction_repository.transactions["1001"]
  end

end
