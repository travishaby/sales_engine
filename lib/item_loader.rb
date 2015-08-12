require 'csv'

class ItemLoader

  attr_reader :item_repository, :item_file

  def initialize(item_repository, item_file = './csvs/items.csv')
    @item_repository = item_repository
    @item_file       = item_file
    self.load_items
  end

  def add_item(id,
              name,
              description,
              unit_price,
              merchant_id,
              created_at,
              updated_at)

    item_repository.items[id.to_i] = Item.new(id.to_i,
                                              name,
                                              description,
                                              unit_price,
                                              merchant_id.to_i,
                                              created_at,
                                              updated_at,
                                              item_repository)
  end

  def load_items
    CSV.foreach(item_file,
                headers: true,
                header_converters: :symbol) do |row|
      add_item(row[:id],
                row[:name],
               row[:description],
               row[:unit_price],
               row[:merchant_id],
               row[:created_at],
               row[:updated_at])
    end
    item_repository.items
  end

end
