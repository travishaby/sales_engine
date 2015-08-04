
class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(id = nil, name = nil, created_at = nil, updated_at = nil)
    @id = id
    @name = name.to_s.delete("\"").to_sym
    @created_at = created_at
    @updated_at = updated_at
  end

end
