#!/usr/bin/env ruby

require 'grocery_list'

# make sure arguments are ok
unless ARGV.length <= 2 && ARGV.length > 0
  puts "Wrong number of arguments"
  puts "Usage: example.rb [source] [:sort-option]"
  exit
end

# parse input arguments
input_source = ARGV[0]
sort_option = ARGV[1] unless ARGV.length < 2

# set options
searcher = GroceryList::IGASearcher.new
searcher.search_options = sort_option ? sort_option : :priceAsc

# search
groceries = GroceryList::Groceries.new(input_source, searcher)
groceries.search_all
