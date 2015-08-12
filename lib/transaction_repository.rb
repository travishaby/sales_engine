require_relative 'transaction'
require_relative 'transaction_loader'

class TransactionRepository

  attr_reader :transactions, :engine

  def initialize(engine = nil)
    @transactions = {}
    @engine = engine
  end

  def all
    transactions.values
  end

  def random
    transactions.values.to_a.sample
  end

  def find_by_id(id)
    transactions[id]
  end

  def find_by(attribute, match)
    found = transactions.detect do |id, object|
      object.send(attribute) == match
    end
    if found.nil?
      found = []
    else
      found = found.last
    end
  end

  def find_by_invoice_id(invoice_id)
    find_by(:invoice_id, invoice_id)
  end

  def find_by_credit_card_number(credit_card_number)
    find_by(:credit_card_number, credit_card_number)

  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    find_by(:credit_card_expiration_date, credit_card_expiration_date)

  end

  def find_by_result(result)
    find_by(:result, result)
  end

  def find_by_all(attribute, match)
    found = transactions.select do |id, object|
      object.send(attribute) == match
    end
    found || empty = []
  end

  def find_all_by_id(id)
    find_by_all(:id, id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_by_all(:invoice_id, invoice_id)
  end

  def find_all_by_credit_card_number(credit_card_number)
    find_by_all(:credit_card_number, credit_card_number)
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    find_by_all(:credit_card_expiration_date, credit_card_expiration_date)
  end

  def find_all_by_result(result)
    find_by_all(:result, result)
  end

  def find_all_by_updated_at(updated_at)
    find_by_all(:updated_at, updated_at)
  end

  def find_all_by_created_at(created_at)
    find_by_all(:created_at, created_at)
  end

  ########## RELATIONSHIP METHODS ##############

  def invoice(invoice_id)
    engine.invoice_by_transaction(invoice_id)
  end

  ########### BUSINESS INTELLIGENCE ###############

  def successful?(transaction_id)
    transactions[transaction_id].result == "success"
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
