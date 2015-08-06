require_relative 'invoice'
require_relative 'invoice_loader'

class InvoiceRepository

  attr_reader :invoices, :invoice_file

  def initialize(invoice_file = './data/invoices.csv')
    @invoices = {}
    @invoice_file = invoice_file
  end

  def invoice_loader
    InvoiceLoader.new(self)
  end

end
