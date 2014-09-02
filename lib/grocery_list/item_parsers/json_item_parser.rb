require 'json'

module GroceryList
  class JsonItemParser < AbstractItemParser
    def self.read(json_string)
      parsed_json = JSON.parse(json_string)
      raise ArgumentError unless parsed_json.is_a? Array

      parsed_json.map do |item|
        Item.new(item.strip)
      end
    end
  end
end
