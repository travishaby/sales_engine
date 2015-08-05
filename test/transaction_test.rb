require_relative 'test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def test_it_initializes_with_correctly_formatted_values
    transaction = Transaction.new("1",
                                  "1",
                                  "4654405418249632",
                                  "",
                                  "success",
                                  "2012-03-27 14:54:09 UTC",
                                  "2012-03-27 14:54:09 UTC")
    assert transaction.id
    assert transaction.invoice_id
    assert transaction.credit_card_number
    assert transaction.credit_card_expiration_date
    assert transaction.created_at
    assert transaction.updated_at
  end
  #
  # def test_it_initializes_with_incorrectly_formatted_name
  #   transaction = Transaction.new("1",
  #                                 "1",
  #                                 "4654405418249632",
  #                                 "",
  #                                 "success",
  #                                 "2012-03-27 14:54:09 UTC",
  #                                 "2012-03-27 14:54:09 UTC")
  #   assert transaction.id
  #   assert transaction.invoice_id
  #   assert transaction.credit_card_number
  #   assert transaction.credit_card_expiration_date
  #   assert transaction.created_at
  #   assert transaction.updated_at
  # end

end
