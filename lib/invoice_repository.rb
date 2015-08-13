require_relative 'invoice'
require_relative 'invoice_loader'

class InvoiceRepository

  attr_reader :invoices, :engine

  def initialize(engine = nil)
    @invoices = {}
    @engine = engine
  end

  def all
    invoices.values
  end

  def random
    invoices.values.to_a.sample
  end

  def find_by_id(id)
    invoices[id]
  end

  def find_by(attribute, match)
    found = invoices.detect do |id, object|
      object.send(attribute) == match
    end
    if found.nil?
      found
    else
      found = found.last
    end
  end

  def find_by_customer_id(customer_id)
    find_by(:customer_id, customer_id)
  end

  def find_by_merchant_id(merchant_id)
    find_by(:merchant_id, merchant_id)
  end

  def find_by_status(status)
    find_by(:status, status)
  end

  def find_by_created_at(created_at)
    find_by(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by(:updated_at, updated_at)
  end

  def find_by_all(attribute, match)
    found = invoices.select do |id, object|
      object.send(attribute) == match
    end
    found || empty = []
  end

  def find_all_by_id(id)
    find_by_all(:id, id)
  end

  def find_all_by_customer_id(customer_id)
    find_by_all(:customer_id, customer_id)
  end

  def find_all_by_merchant_id(merchant_id)
    find_by_all(:merchant_id, merchant_id)
  end

  def find_all_by_status(status)
    find_by_all(:status, status)
  end

  def find_all_by_created_at(created_at)
    find_by_all(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_by_all(:updated_at, updated_at)
  end

  # RELATIONSHIPS

  def transactions(invoice_id)
    engine.transactions_by_invoice(invoice_id)
  end

  def invoice_items(invoice_id)
    engine.invoice_items_by_invoice(invoice_id)
  end

  def items(invoice_id)
    engine.items_by_invoice(invoice_id)
  end

  def customer(customer_id)
    engine.customer_by_invoice(customer_id)
  end

  def merchant(merchant_id)
    engine.merchant_by_invoice(merchant_id)
  end

  ######## INVOICE CREATION ########

  def create(invoice_info)
    invoice_id = invoices.keys.sort.last + 1
    items = invoice_info[:items]
    engine.create_invoice_items(invoice_id, items)
    create_invoice(invoice_info)
  end

  def create_invoice(invoice_info)
    id = invoices.keys.sort.last + 1
    customer_id = invoice_info[:customer].id
    merchant_id = invoice_info[:merchant].id
    status = invoice_info[:status]
    created_at = Date.parse(Time.now.to_s).to_s
    updated_at = Date.parse(Time.now.to_s).to_s
    invoices[id] = Invoice.new(id,
                               customer_id,
                               merchant_id,
                               status,
                               created_at,
                               updated_at,
                               self)
  end

  def charge(invoice_id, charge_info)
    engine.charge(invoice_id, charge_info)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
