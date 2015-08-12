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

end
