require_relative 'merchant'
require_relative 'merchant_loader'

class MerchantRepository

  attr_reader :merchants, :engine

  def initialize(engine = nil)
    @merchants = {}
    @engine = engine
  end

  def all
    merchants.values
  end

  def random
    merchants.values.to_a.sample
  end

  def find_by_id(id)
    merchants[id]
  end

  def find_by(attribute, match)
    found = merchants.detect do |id, object|
      object.send(attribute).downcase == match.downcase
    end.last 
    found || empty = []
  end

  def find_by_name(name)
    find_by(:name, name)
  end

  def find_by_created_at(created_at)
    find_by(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by(:updated_at, updated_at)
  end

  def find_by_all(attribute, match)
    found = merchants.select do |id, object|
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

  def find_all_by_created_at(created_at)
    find_by_all(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_by_all(:updated_at, updated_at)
  end

###########RELATIONSHIP METHODS##################

  def items(merchant_id)
    engine.items_by_merchant(merchant_id)
  end

  def invoices(merchant_id)
    engine.invoices_by_merchant(merchant_id)
  end

end
