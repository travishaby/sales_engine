require_relative 'item'
require_relative 'item_loader'

class ItemRepository

  attr_reader :items, :item_file, :engine

  def initialize(engine = nil, item_file = './data/items.csv')
    @items = {}
    @item_file = item_file
    @engine = engine
  end

  def item_loader
    ItemLoader.new(self)
  end

end
