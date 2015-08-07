require 'csv'

class InvoiceItemLoader

  attr_reader :invoice_item_repository, :invoice_item_file

  def initialize(invoice_item_repository, invoice_item_file = './data/invoice_items.csv')
    @invoice_item_repository = invoice_item_repository
    @invoice_item_file       = invoice_item_file
    self.load_invoice_items
  end

  def add_invoice_item(id,
                       item_id,
                       invoice_id,
                       quantity,
                       unit_price,
                       created_at,
                       updated_at)
    invoice_item_repository.invoice_items[id] = InvoiceItem.new(id,
                    item_id,
                    invoice_id,
                    quantity,
                    unit_price,
                    created_at,
                    updated_at)
  end

  def load_invoice_items
    CSV.foreach(invoice_item_file,
                headers: true,
                header_converters: :symbol) do |row|
      add_invoice_item(row[:id],
               row[:item_id],
               row[:invoice_id],
               row[:quantity],
               row[:unit_price],
               row[:created_at],
               row[:updated_at])
    end
    invoice_item_repository.invoice_items
  end


end
