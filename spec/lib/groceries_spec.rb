require 'grocery_list'
require './spec/stubs/IGASearcherStub'

ITEMS_AS_STRING = "bread, philadelphia, bagel all dressed"
ITEMS_AS_JSON = '["bread", "philadelphia", "bagel all dressed"]'

describe GroceryList do
  it "should accept a list as a string and a searcher" do
    expect { GroceryList.search_all(ITEMS_AS_STRING, IGASearcherStub.new) }.to_not raise_error
  end

  it "should accept a list as a path and a searcher" do
    expect { GroceryList.search_all('./spec/fixtures/list_test.md', IGASearcherStub.new) }.to_not raise_error
  end

  it "should accept a list as a json string and a searcher" do
    expect { GroceryList.search_all(ITEMS_AS_JSON, IGASearcherStub.new) }.to_not raise_error
  end

  it "should throw an error if path isn't readble or if not a string" do
    expect {GroceryList.search_all('./lib', IGASearcherStub.new)}.to raise_error
    expect {GroceryList.search_all(5, IGASearcherStub.new)}.to raise_error
  end

  it "should not throw an error if empty string is provided" do
    expect {GroceryList.search_all('', IGASearcherStub.new)}.to_not raise_error
  end

  it "should not throw an error if the searcher isn't a searcher" do
    expect {GroceryList.search_all('', 'IGASearcherStub')}.to raise_error
  end

  it "should search all items" do
    expect { GroceryList.search_all('./spec/fixtures/list_test.md', IGASearcherStub.new) }.to_not raise_error
  end

  it "should search all items sorted by priceAsc" do
    searcher = IGASearcherStub.new
    searcher.search_options = :priceAsc
    expect { GroceryList.search_all('./spec/fixtures/list_test.md', searcher) }.to_not raise_error
  end
end
