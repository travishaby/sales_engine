require_relative 'invoice'
require_relative 'invoice_loader'

class InvoiceRepository

  attr_reader :invoices

  def initialize
    @invoices = {}
  end

  def invoice_loader
    InvoiceLoader.new(self)
  end

end
