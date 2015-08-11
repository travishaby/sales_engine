require 'csv'
require 'bigdecimal'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'item_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'transaction'
require_relative 'transaction_repository'

class SalesEngine

  attr_reader :merchant_repository,
              :invoice_repository,
              :item_repository,
              :invoice_item_repository,
              :customer_repository,
              :transaction_repository

  def initialize
    @merchant_repository     = merchant_repository
    @invoice_repository      = invoice_repository
    @item_repository         = item_repository
    @invoice_item_repository = invoice_item_repository
    @customer_repository     = customer_repository
    @transaction_repository  = transaction_repository
  end

  def startup
    @merchant_repository     ||= MerchantRepository.new(self)
    @invoice_repository      ||= InvoiceRepository.new(self)
    @item_repository         ||= ItemRepository.new(self)
    @invoice_item_repository ||= InvoiceItemRepository.new(self)
    @customer_repository     ||= CustomerRepository.new(self)
    @transaction_repository  ||= TransactionRepository.new(self)
    load_repositories
  end

  def load_repositories
    merchant_loader = MerchantLoader.new(merchant_repository)
    invoice_loader = InvoiceLoader.new(invoice_repository)
    item_loader = ItemLoader.new(item_repository)
    invoice_item_loader = InvoiceItemLoader.new(invoice_item_repository)
    customer_loader = CustomerLoader.new(customer_repository)
    transaction_loader = TransactionLoader.new(transaction_repository)
  end

  def fixture_startup
    @merchant_repository     ||= MerchantRepository.new(self)
    @invoice_repository      ||= InvoiceRepository.new(self)
    @item_repository         ||= ItemRepository.new(self)
    @invoice_item_repository ||= InvoiceItemRepository.new(self)
    @customer_repository     ||= CustomerRepository.new(self)
    @transaction_repository  ||= TransactionRepository.new(self)
    load_fixture_repositories
  end

  def load_fixture_repositories
    merchant_loader = MerchantLoader.new(merchant_repository, './fixtures/merchants.csv')
    invoice_loader = InvoiceLoader.new(invoice_repository, './fixtures/invoices.csv')
    item_loader = ItemLoader.new(item_repository, './fixtures/items.csv')
    invoice_item_loader = InvoiceItemLoader.new(invoice_item_repository, './fixtures/invoice_items.csv')
    customer_loader = CustomerLoader.new(customer_repository, './fixtures/customers.csv')
    transaction_loader = TransactionLoader.new(transaction_repository, './fixtures/transactions.csv')
  end

  # merchant

  def items_by_merchant(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id)
  end

  def invoices_by_merchant(merchant_id)
    invoice_repository.find_all_by_merchant_id(merchant_id)
  end

  # invoice

  def transactions_by_invoice(invoice_id)
    transaction_repository.find_all_by_invoice_id(invoice_id)
  end

  def invoice_items_by_invoice(invoice_id)
    invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end

  def items_by_invoice(invoice_id)
    invoice_items_by_invoice(invoice_id).collect do |invoice_item|
      item_repository.find_by_id(invoice_item[1].item_id)
    end
  end

  def customer_by_invoice(customer_id)
    customer_repository.find_by_id(customer_id)
  end

  def merchant_by_invoice(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end

  # customer

  def invoices_by_customer(customer_id)
    invoice_repository.find_all_by_customer_id(customer_id)
  end

  # transaction

  def invoices_by_transaction(invoice_id)
    invoice_repository.find_all_by_id(invoice_id)
  end

  #invoice_item

  def invoice_by_invoice_id(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def item_by_item_id(item_id)
    item_repository.find_by_id(item_id)
  end

  #item

  def invoice_items_by_item_id(item_id)
    invoice_item_repository.find_all_by_item_id(item_id)
  end

  def merchant_by_merchant_id(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end

####### Business Intelligence #######

  def successful_invoices(merchant_id, date = nil)
    invoices = invoices_by_merchant(merchant_id)
    invoices = invoices.values.select do |invoice|
      check_transactions(invoice)
    end
    if date
      invoices.select do |invoice|
        Date.parse(invoice_repository.invoices[invoice.id].created_at[0..9]) == date
      end
    else
      invoices
    end
  end

  def check_transactions(invoice)
    transaction_repository.find_all_by_invoice_id(invoice.id).values.any? do |transaction|
      transaction_repository.successful?(transaction.id)
    end
  end

  def successful_items(merchant_id, date = nil)
    invoice_items = successful_invoices(merchant_id, date).map {|invoice|
      invoice_items_by_invoice(invoice.id).values}
    invoice_items.flatten
  end

  def revenue(merchant_id, date = nil)
    successful_items(merchant_id, date).reduce(0) do |sum, invoice_item|
      sum + (invoice_item.quantity.to_i * invoice_item.unit_price)
    end
  end

  def favorite_customer(merchant_id)
    merchant_invoices = successful_invoices(merchant_id)
    grouped = merchant_invoices.group_by do |invoice|
      invoice.customer_id
    end
    grouped = grouped.values.sort_by {|array| array.size} #THIS IS SO
    best_customer = grouped.last.size
  end

  # I think we need to restructure this with the date so check_transactions is also taking the date in an if/ else. if no date, run as is. if date, run as invoice_id and created_at.



end
