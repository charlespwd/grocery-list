require "grocery_list"

class IGASearcherStub < GroceryList::IGASearcher
  def search(item)
    raise ArgumentError, "#{item} isn't an Item" unless item.is_a? GroceryList::Item
    puts url(item.item_name)
  end
end
