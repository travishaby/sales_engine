require 'csv'

class InvoiceLoader

  attr_reader :invoice_repository, :invoice_file

  def initialize(invoice_repository, invoice_file = './data/invoices.csv')
    @invoice_repository = invoice_repository
    @invoice_file       = invoice_file
    self.load_invoices
  end

  def add_invoice(id, customer_id, merchant_id, status, created_at, updated_at)
      invoice_repository.invoices[id] = Invoice.new(id,
                                                    customer_id,
                                                    merchant_id,
                                                    status,
                                                    created_at,
                                                    updated_at)
  end

  def load_invoices
    CSV.foreach(invoice_file, headers: true, header_converters: :symbol) do |row|
      add_invoice(row[:id],
                  row[:customer_id],
                  row[:merchant_id],
                  row[:status],
                  row[:created_at],
                  row[:updated_at])
    end
    invoice_repository.invoices
  end

end
