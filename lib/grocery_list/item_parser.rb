module GroceryList
  class AbstractItemParser
    def self.read(string)
      raise NotImplementedError
    end
  end
end

require 'grocery_list/item_parsers/string_item_parser'
require 'grocery_list/item_parsers/file_item_parser'
require 'grocery_list/item_parsers/json_item_parser'
