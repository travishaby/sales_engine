require 'csv'
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
    @merchant_repository ||= MerchantRepository.new(self)
    @invoice_repository ||= InvoiceRepository.new(self)
    @item_repository ||= ItemRepository.new(self)
    @invoice_item_repository ||= InvoiceItemRepository.new(self)
    @customer_repository ||= CustomerRepository.new(self)
    @transaction_repository ||= TransactionRepository.new(self)
    load_repositories
  end

  def load_repositories
    merchant_repository.merchant_loader
    invoice_repository.invoice_loader
    item_repository.item_loader
    invoice_item_repository.invoice_item_loader
    customer_repository.customer_loader
    transaction_repository.transaction_loader
  end

  def items(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id)
  end

end
