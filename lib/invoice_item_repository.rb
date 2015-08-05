require_relative 'invoice_item'
require_relative 'invoice_item_loader'

class InvoiceItemRepository

  attr_reader :invoice_items

  def initialize
    @invoice_items = {}
  end

  def invoice_item_loader
    InvoiceItemLoader.new(self)
  end

end
