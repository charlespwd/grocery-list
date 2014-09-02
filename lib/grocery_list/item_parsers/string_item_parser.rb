module GroceryList
  class StringItemParser < AbstractItemParser
    def self.read(string)
      raise ArgumentError unless string.is_a? String
      string.split(',').map {|s| Item.new(s.strip)}
    end
  end
end
