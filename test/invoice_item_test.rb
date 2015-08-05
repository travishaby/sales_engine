require_relative 'test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_it_initializes_with_nil_values
    invoice_item = InvoiceItem.new
    refute invoice_item.id
    refute invoice_item.item_id
    refute invoice_item.invoice_id
    refute invoice_item.quantity
    refute invoice_item.unit_price
    refute invoice_item.created_at
    refute invoice_item.updated_at
  end

  def test_it_initializes_with_values
    invoice_item = InvoiceItem.new("id",
                                   "item_id",
                                   "invoice_id",
                                   "quantity",
                                   "unit_price",
                                   "created_at",
                                   "updated_at")
    assert invoice_item.id
    assert invoice_item.item_id
    assert invoice_item.invoice_id
    assert invoice_item.quantity
    assert invoice_item.unit_price
    assert invoice_item.created_at
    assert invoice_item.updated_at
  end

  def test_calling_specific_values
    invoice_item = InvoiceItem.new("id",
                                   "item_id",
                                   "invoice_id",
                                   "quantity",
                                   "unit_price",
                                   "created_at",
                                   "updated_at")
    assert_equal "id", invoice_item.id
    assert_equal "unit_price", invoice_item.unit_price
  end


end
