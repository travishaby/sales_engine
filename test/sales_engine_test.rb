require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.new
    sales_engine.fixture_startup
    sales_engine
  end

  def data_setup
    sales_engine = SalesEngine.new
    sales_engine.startup
    sales_engine
  end

  def test_successful_invoices
    result = setup.successful_invoices("8")
    assert_equal ["12"], result
  end
  #
  # def test_successful_invoices_with_all_data
  #   result = data_setup.successful_invoices("8")
  #   assert_equal ["12"], result
  # end

  def test_check_transactions
    result1 = setup.check_transactions("12")
    result2 = setup.check_transactions("13")
    assert result1
    refute result2
  end

  def test_finding_successful_items
  result = setup.successful_items("8").size
  assert_equal 6, result
  end

  def test_find_revenue
    result = setup.revenue("8")
    assert_equal BigDecimal.new("10161.56"), result
  end

  def test_case_name
    result = setup.revenue("8")
    assert_equal BigDecimal.new("10161.56"), result
  end
end
