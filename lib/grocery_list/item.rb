module GroceryList
  class Item
    attr_reader :item_name

    def initialize(item_name)
      @item_name = item_name
    end

    def ==(y)
      y.item_name == @item_name
    end
  end
end

