require 'csv'

class TransactionLoader

  attr_reader :transaction_repository, :transaction_file

  def initialize(transaction_repository,
    transaction_file = './csvs/transactions.csv')
    @transaction_repository = transaction_repository
    @transaction_file       = transaction_file
    self.load_transactions
  end

  def add_transaction(id,
                      invoice_id,
                      credit_card_number,
                      credit_card_expiration_date,
                      result,
                      created_at,
                      updated_at)
    transaction_repository.
      transactions[id.to_i] = Transaction.new(id.to_i,
                                              invoice_id.to_i,
                                              credit_card_number,
                                              credit_card_expiration_date,
                                              result,
                                              created_at,
                                              updated_at,
                                              transaction_repository)
  end

  def load_transactions
    CSV.foreach(transaction_file,
                headers: true,
                header_converters: :symbol) do |row|
      add_transaction(row[:id],
                      row[:invoice_id],
                      row[:credit_card_number],
                      row[:credit_card_expiration_date],
                      row[:result],
                      row[:created_at],
                      row[:updated_at])
    end
    transaction_repository.transactions
  end

end
