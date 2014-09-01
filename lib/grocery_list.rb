require 'json'
require 'launchy'
require "grocery_list/version"

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

  class Groceries
    attr_reader :items, :searcher

    @@source_type_tests = {
      :is_json_array? => ->(s) { s.start_with? '[' },
      :is_a_path?     => ->(s) { s.is_a? String and File.readable? s },
      :is_a_string?   => ->(s) { s.is_a? String and not File.readable? s},
    }
    @@searchers = {
      :is_json_array? => ->(s) { JsonItemReader.new.read(s) },
      :is_a_path?     => ->(s) { FileItemReader.new.read(s) },
      :is_a_string?   => ->(s) { StringItemReader.new.read(s) },
    }

    def initialize(items_source, searcher)
      raise ArgumentError, "isn't a valid source" unless is_valid_source? items_source
      raise ArgumentError, "searcher isn't a Searcher" unless searcher.is_a? Searcher
      @items = items_from_source(items_source)
      @searcher = searcher
    end

    def search_all
      @items.each do |item|
        @searcher.search(item)
      end
    end

    private
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

  class Searcher
    def search(item)
      raise NotImplementedError
    end
  end

  class IGASearcher < Searcher
    attr_reader :search_url
    attr :search_options

    @@valid_options = [
      :priceDesc,
      :priceAsc,
      :DisplayNameDesc,
      :DisplayNameAsc,
    ]

    def initialize
      @search_url = "http://magasin.iga.net/Search/BasicSearch.aspx?Search="
      @search_options = nil
      @testing = false
    end

    def search(item)
      raise ArgumentError, "#{item} isn't an Item" unless item.is_a? Item
      Launchy.open url(item.item_name)
    end

    def search_options=(option)
      raise ArgumentError, "#{option} is an invalid option" unless @@valid_options.include? option
      @search_options = option
    end

    def search_options
      @search_options
    end

    private
    def url(item_name)
      "#{@search_url}#{url_encode(item_name)}#{encoded_options}"
    end

    def url_encode(str)
      str.gsub(/ /, '%20')
    end

    def encoded_options
      @search_options ? "&sort=#{@search_options.to_s}" : ""
    end
  end

  ##
  # ItemReader
  # Base class / Interface like
  class ItemReader
    def read(string)
      raise NotImplementedError
    end
  end

  ##
  # StringItemReader
  # Turns a comma separated list of items into an Array of Item
  class StringItemReader < ItemReader
    def read(string)
      raise ArgumentError unless string.is_a? String
      string.split(',').map {|s| Item.new(s.strip)}
    end
  end

  ##
  # FileItemReader
  # Turns a markdown file into an Array of Item
  class FileItemReader < ItemReader
    def read(file_path)
      raise ArgumentError unless file_path.is_a? String
      file = IO.read(file_path)
      items_from_file(file)
    end

    private
    def items_from_file(file)
      file.split("\n").map do |line|
        line_to_item(line)
      end.select do |item|
        item.is_a? Item
      end
    end

    def line_to_item(line)
      Item.new(item_name(line)) if is_valid_item(line)
    end

    def is_valid_item(line)
      line.start_with? " *"
    end

    def item_name(line)
      line[2..-1].strip
    end
  end

  ##
  # JsonItemReader
  # turns a simple JSON Array into an Array of Item
  class JsonItemReader < ItemReader
    def read(json_string)
      parsed_json = JSON.parse(json_string)
      raise ArgumentError unless parsed_json.is_a? Array

      parsed_json.map do |item|
        Item.new(item.strip)
      end
    end
  end
end
