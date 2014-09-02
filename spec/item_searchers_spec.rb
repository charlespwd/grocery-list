require "spec_helper"

require "./spec/stubs/IGASearcherStub"

describe GroceryList::AbstractSearcher do
  it "should have a search method that is not implemented" do
    searcher = GroceryList::AbstractSearcher.new
    expect{ searcher.search("") }.to raise_error
  end
end

describe GroceryList::IGASearcher do
  it "should have a search method that is implemented" do
    searcher = GroceryList::IGASearcher.new
    expect{ searcher.search("") }.to raise_error
    # expect{ searcher.search(Item.new("pain")) }.to_not raise_error
  end

  it "should throw an error if trying to set an invalid option" do
    searcher = IGASearcherStub.new
    expect { searcher.search_options = :invalid }.to raise_error
    expect { searcher.search_options = :priceAsc }.to_not raise_error
    expect { searcher.search_options = :priceDesc }.to_not raise_error
    expect { searcher.search_options = :DisplayNameAsc }.to_not raise_error
    expect { searcher.search_options = :DisplayNameDesc }.to_not raise_error
  end
end
