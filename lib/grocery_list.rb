require 'launchy'

module GroceryList
  class << self
    attr_reader :items, :searcher

    @@source_type_tests = {
      :is_json_array? => ->(s) { s.start_with? '[' },
      :is_a_path?     => ->(s) { s.is_a? String and File.readable? s },
      :is_a_string?   => ->(s) { s.is_a? String and not File.readable? s},
    }
    @@searchers = {
      :is_json_array? => ->(s) { JsonItemParser.read(s) },
      :is_a_path?     => ->(s) { FileItemParser.read(s) },
      :is_a_string?   => ->(s) { StringItemParser.read(s) },
    }

    def search_all(items_source, searcher = IGASearcher.new)
      validate_input(items_source, searcher)
      @items.each do |item|
        @searcher.search(item)
      end
    end

    private
    def validate_input(items_source, searcher)
      raise ArgumentError, "isn't a valid source" unless is_valid_source? items_source
      raise ArgumentError, "searcher isn't a AbstractSearcher" unless searcher.kind_of? AbstractSearcher
      @items = items_from_source(items_source)
      @searcher = searcher
    end

    def items_from_source(items_source)
      @@source_type_tests.each do |key, test|
        if test.call(items_source)
          return @@searchers[key].call(items_source)
        end
      end
    end

    def is_valid_source?(items_source)
      @@source_type_tests.values.any? {|f| f.call(items_source)}
    end
  end
end

require 'grocery_list/item'
require 'grocery_list/item_parser'
require 'grocery_list/item_searcher'
require "grocery_list/version"
