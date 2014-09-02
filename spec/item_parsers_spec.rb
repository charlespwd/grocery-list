require 'spec_helper'

describe GroceryList::AbstractItemParser do
  let(:reader) { GroceryList::AbstractItemParser }

  it "should have an unimplemented read method" do
    expect{ reader.read('tostitos') }.to raise_error
  end
end

describe GroceryList::StringItemParser do
  let(:reader) { GroceryList::StringItemParser }

  it "should turn a string into an array of item" do
    items = reader.read(ITEMS_AS_STRING)
    expect(items.is_a? Array).to eql(true)
  end
end

describe GroceryList::FileItemParser do
  let(:reader) { GroceryList::FileItemParser }

  it "should raise an error if no files are found" do
    expect{ reader.read('null') }.to raise_error
    expect{ reader.read('./spec/spec_helper.rb') }.to_not raise_error
  end

  it "should only read lines prefixed by a star" do
    expected_result = GroceryList::StringItemParser.read(ITEMS_AS_STRING)

    expect(reader.read('./spec/fixtures/list_test.md')).to eq(expected_result)
  end
end

describe GroceryList::JsonItemParser do
  let(:reader) { GroceryList::JsonItemParser }

  it "should raise an error if json isn't an array" do
    expect{ reader.read(42) }.to raise_error
    expect{ reader.read('null') }.to raise_error
    expect{ reader.read(ITEMS_AS_JSON) }.to_not raise_error
  end

  it "should turn parsed array into an array of items" do
    expected_result = GroceryList::StringItemParser.read(ITEMS_AS_STRING)

    expect(reader.read(ITEMS_AS_JSON)).to eq(expected_result)
  end
end
