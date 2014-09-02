if RUBY_VERSION >= '1.9.2' then
  require 'simplecov'
  puts "Using coverage!" if ENV['COVERAGE']
  SimpleCov.start if ENV['COVERAGE']
end

ITEMS_AS_STRING = "bread, philadelphia, bagel all dressed"
ITEMS_AS_JSON = '["bread", "philadelphia", "bagel all dressed"]'
require 'grocery_list'
