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

  def all
    items.values
  end

  def random
    items.values.to_a.sample
  end

  def find_by_id(id)
    items[id]
  end

  def find_by(attribute, match)
    found = items.detect do |id, object|
      object.send(attribute).downcase == match.downcase
    end
    found || empty = []
  end

  def find_by_name(name)
    find_by(:name, name)
  end

  def find_by_description(description)
    find_by(:description, description)
  end

  def find_by_unit_price(unit_price)
    find_by(:unit_price, unit_price)
  end

  def find_by_merchant_id(merchant_id)
    find_by(:merchant_id, merchant_id)
  end

  def find_by_created_at(created_at)
    find_by(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by(:updated_at, updated_at)
  end

  def find_by_all(attribute, match)
    found = items.select do |id, object|
      object.send(attribute).downcase == match.downcase
    end
    found || empty = []
  end

  def find_all_by_id(id)
    find_by_all(:id, id)
  end

  def find_all_by_name(name)
    find_by_all(:name, name)
  end

  def find_all_by_description(description)
    find_by_all(:description, description)
  end

  def find_all_by_unit_price(unit_price)
    find_by_all(:unit_price, unit_price)
  end

  def find_all_by_merchant_id(merchant_id)
    find_by_all(:merchant_id, merchant_id)
  end

  def find_all_by_created_at(created_at)
    find_by_all(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_by_all(:updated_at, updated_at)
  end
  
end
