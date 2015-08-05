require_relative 'test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  def test_it_initializes_with_values
    invoice = Invoice.new("1",
                          "1",
                          "26",
                          "shipped",
                          "2012-03-25 09:54:09 UTC",
                          "2012-03-25 09:54:09 UTC")
    assert invoice.id
    assert invoice.customer_id
    assert invoice.merchant_id
    assert invoice.status
    assert invoice.created_at
    assert invoice.updated_at
  end
  # 
  # def test_it_initializes_with_incorrectly_formatted_name
  #   invoice = Invoice.new("1",
  #                         "1",
  #                         "26",
  #                         "shipped",
  #                         "2012-03-25 09:54:09 UTC",
  #                         "2012-03-25 09:54:09 UTC")
  #   assert invoice.id
  #   assert invoice.customer_id
  #   assert invoice.merchant_id
  #   assert invoice.status
  #   assert invoice.created_at
  #   assert invoice.updated_at
  # end

end
