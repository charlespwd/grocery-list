require 'grocery_list'

ITEMS_AS_STRING = "bread, philadelphia, bagel all dressed"
ITEMS_AS_JSON = '["bread", "philadelphia", "bagel all dressed"]'

describe GroceryList::ItemReader do
  it "should have an unimplemented read method" do
    reader = GroceryList::ItemReader.new
    expect{ reader.read }.to raise_error
  end
end

describe GroceryList::StringItemReader do
  it "should turn a string into an array of item" do
    reader = GroceryList::StringItemReader.new
    items = reader.read(ITEMS_AS_STRING)
    expect(items.is_a? Array).to eql(true)
  end
end

describe GroceryList::FileItemReader do
  before(:each) do
    @reader = GroceryList::FileItemReader.new
  end

  it "should raise an error if no files are found" do
    expect{ @reader.read('null') }.to raise_error
    expect{ @reader.read('./spec/lib/searcher_spec.rb') }.to_not raise_error
  end

  it "should only read lines prefixed by a star" do
    expected_result = GroceryList::StringItemReader.new.read(ITEMS_AS_STRING)

    expect(@reader.read('./spec/fixtures/list_test.md')).to eq(expected_result)
  end
end

describe GroceryList::JsonItemReader do
  before(:each) do
    @reader = GroceryList::JsonItemReader.new
  end

  it "should raise an error if json isn't an array" do
    expect{ @reader.read(42) }.to raise_error
    expect{ @reader.read('null') }.to raise_error
    expect{ @reader.read(ITEMS_AS_JSON) }.to_not raise_error
  end

  it "should turn parsed array into an array of items" do
    expected_result = GroceryList::StringItemReader.new.read(ITEMS_AS_STRING)

    expect(@reader.read(ITEMS_AS_JSON)).to eq(expected_result)
  end
end
