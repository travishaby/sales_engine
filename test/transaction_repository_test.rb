require_relative 'test_helper'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def data_setup
    transaction_repository = TransactionRepository.new
    transaction_loader = TransactionLoader.new(transaction_repository)
    transaction_repository
  end

  def fixture_setup
    transaction_repository = TransactionRepository.new
    transaction_loader = TransactionLoader.new(transaction_repository, './fixtures/transactions.csv')
    transaction_repository
  end

  def test_repo_starts_as_empty_hash
    transaction_repository = TransactionRepository.new
    assert transaction_repository.transactions
  end

  def test_accesses_transaction_id_with_id
    assert_equal "1", fixture_setup.transactions["1"].id
  end

  def test_accesses_transaction_invoice_id_with_id
    assert_equal "2", fixture_setup.transactions["2"].invoice_id
  end

  def test_accesses_transaction_credit_card_number_with_id
    assert_equal "4354495077693036", fixture_setup.transactions["3"].credit_card_number
  end

  def test_accesses_transaction_credit_card_expiration_date_with_id
    assert_equal nil, fixture_setup.transactions["4"].credit_card_expiration_date
  end

  def test_accesses_transaction_created_at_with_id
    assert_equal "2012-03-27 14:54:10 UTC",
    fixture_setup.transactions["5"].created_at
  end

  def test_accesses_transaction_updated_at_with_id
    assert_equal "2012-03-27 14:54:10 UTC",
    fixture_setup.transactions["6"].updated_at
  end

  def test_attempt_access_nonexistent_value
    refute data_setup.transactions["5600"]
  end

  def test_that_all_returns_all_instances
    assert_equal 99, fixture_setup.all.size
  end

  def test_random_usually_returns_different_transaction
    trans1 = fixture_setup.random
    trans2 = fixture_setup.random
    5.times do
      assert trans1 != trans2
      trans2 = fixture_setup.random
    end
  end

  def test_general_find_by_method_with_invoice_id
    assert_equal "23",
    fixture_setup.find_by(:invoice_id,"22").id
  end

  def test_returns_single_object_with_matching_id
    assert_equal "6", fixture_setup.find_by_id("6").id
  end

  def test_returns_single_object_with_matching_credit_card_number
    assert_equal "5", fixture_setup.find_by_credit_card_number("4844518708741275").id
  end

  def test_returns_single_object_with_matching_result
    assert_equal "1",
    fixture_setup.find_by_result("success").id
  end

  def test_general_find_by_all_method_with_id
    assert_equal ["3"],
    fixture_setup.find_by_all(:id, "3").keys
  end

  def test_general_find_by_all_method_with_credit_card_number
    assert_equal 1,
    fixture_setup.find_by_all(:credit_card_number, "4140149827486249").size
  end

  def test_general_find_by_all_returns_array_size_zero_if_name_not_found
    assert_equal 0,
    fixture_setup.find_by_all(:invoice_id,"500").size
  end

  def test_find_all_by_id
    assert_equal 1, fixture_setup.find_all_by_id("76").size
  end

  def test_find_all_by_invoice_id
    assert_equal 1, fixture_setup.find_all_by_invoice_id("50").size
  end

  def test_find_all_by_first_name_with_specific_keys
    assert_equal ["11", "12", "14", "15", "32", "36", "37", "39", "40", "53", "54", "59", "60", "82", "83", "84"], fixture_setup.find_all_by_result("failed").keys
  end

  def test_find_all_by_created_at
    assert_equal 20, fixture_setup.find_all_by_created_at("2012-03-27 14:54:10 UTC").size
  end

  def test_find_all_by_updated_at
    assert_equal 20, fixture_setup.find_all_by_updated_at("2012-03-27 14:54:10 UTC").size
  end

######### BUSINESS INTELLIGENCE #############

  def test_filters_for_successful_transactions
    result1 = fixture_setup.successful?("11")
    result2 = fixture_setup.successful?("13")    
    refute result1
    assert result2
  end

end
