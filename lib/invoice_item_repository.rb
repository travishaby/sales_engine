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

  def all
    invoice_items.values
  end

  def random
    invoice_items.values.to_a.sample
  end

  def find_by_id(id)
    invoice_items[id]
  end

  def find_by(attribute, match)
    found = invoice_items.detect do |id, object|
      object.send(attribute) == match
    end
    found || empty = []
  end

  def find_by_item_id(item_id)
    find_by(:item_id, item_id)
  end

  def find_by_invoice_id(invoice_id)
    find_by(:invoice_id, invoice_id)
  end

  def find_by_quantity(quantity)
    find_by(:quantity, quantity)
  end

  def find_by_unit_price(unit_price)
    find_by(:unit_price, unit_price)
  end

  def find_by_created_at(created_at)
    find_by(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by(:updated_at, updated_at)
  end

  def find_by_all(attribute, match)
    found = invoice_items.select do |id, object|
      object.send(attribute) == match
    end
    found || empty = []
  end

  def find_all_by_id(id)
    find_by_all(:id, id)
  end

  def find_all_by_item_id(item_id)
    find_by_all(:item_id, item_id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_by_all(:invoice_id, invoice_id)
  end

  def find_all_by_quantity(quantity)
    find_by_all(:quantity, quantity)
  end

  def find_all_by_unit_price(unit_price)
    find_by_all(:unit_price, unit_price)
  end

  def find_all_by_created_at(created_at)
    find_by_all(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_by_all(:updated_at, updated_at)
  end

end
