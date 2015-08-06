require_relative 'invoice_item'
require_relative 'invoice_item_loader'

class InvoiceItemRepository

  attr_reader :invoice_items, :invoice_item_file, :engine

  def initialize(engine = nil, invoice_item_file = './data/invoice_items.csv')
    @invoice_items     = {}
    @invoice_item_file = invoice_item_file
    @engine            = engine
  end

  def invoice_item_loader
    InvoiceItemLoader.new(self)
  end

end
