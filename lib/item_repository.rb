require_relative 'item'
require_relative 'item_loader'

class ItemRepository

  attr_reader :items

  def initialize
    @items = {}
  end

  def item_loader
    ItemLoader.new(self)
  end

end
