module GroceryList
  class AbstractSearcher
    def search(item)
      raise NotImplementedError
    end
  end
end

require 'grocery_list/item_searchers/iga_item_searcher'
