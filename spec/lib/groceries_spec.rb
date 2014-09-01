require 'grocery_list'
require './spec/stubs/IGASearcherStub'

ITEMS_AS_STRING = "bread, philadelphia, bagel all dressed"
ITEMS_AS_JSON = '["bread", "philadelphia", "bagel all dressed"]'

describe GroceryList::Groceries do
  it "should accept a list as a string and a searcher" do
    expectations = GroceryList::StringItemReader.new.read(ITEMS_AS_STRING)
    groceries = GroceryList::Groceries.new(ITEMS_AS_STRING, IGASearcherStub.new)
    expect(groceries.items).to eq(expectations)
  end

  it "should accept a list as a path and a searcher" do
    expectations = GroceryList::StringItemReader.new.read(ITEMS_AS_STRING)
    groceries = GroceryList::Groceries.new('./spec/fixtures/list_test.md', IGASearcherStub.new)
    expect(groceries.items).to eq(expectations)
  end

  it "should accept a list as a json string and a searcher" do
    expectations = GroceryList::StringItemReader.new.read(ITEMS_AS_STRING)
    groceries = GroceryList::Groceries.new(ITEMS_AS_JSON, IGASearcherStub.new)
    expect(groceries.items).to eq(expectations)
  end

  it "should throw an error if path isn't readble or if not a string" do
    expect {GroceryList::Groceries.new('./lib', IGASearcherStub.new)}.to raise_error
    expect {GroceryList::Groceries.new(5, IGASearcherStub.new)}.to raise_error
  end

  it "should not throw an error if empty string is provided" do
    expect {GroceryList::Groceries.new('', IGASearcherStub.new)}.to_not raise_error
  end

  it "should not throw an error if the searcher isn't a searcher" do
    expect {GroceryList::Groceries.new('', 'IGASearcherStub')}.to raise_error
  end

  it "should search all items" do
    groceries = GroceryList::Groceries.new('./spec/fixtures/list_test.md', IGASearcherStub.new)
    groceries.search_all
  end

  it "should search all items sorted by priceAsc" do
    searcher = IGASearcherStub.new
    searcher.search_options = :priceAsc
    groceries = GroceryList::Groceries.new('./spec/fixtures/list_test.md', searcher)
    groceries.search_all
  end
end
