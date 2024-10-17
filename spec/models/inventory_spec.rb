require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it "is valid with valid attributes" do
    inventory = build(:inventory)
    expect(inventory).to be_valid
  end

  it "is invalid without a stock quantity" do
    inventory = build(:inventory, stock_quantity: nil)
    expect(inventory).to_not be_valid
    expect(inventory.errors[:stock_quantity]).to include("can't be blank")
  end

  it "is invalid without an associated item" do
    inventory = build(:inventory, item: nil)
    expect(inventory).to_not be_valid
  end

  it "belongs to an item" do
    item = create(:item)
    inventory = build(:inventory, item: item)
    expect(inventory).to be_valid
  end

  it "is invalid with negative values for stock quantity" do
    inventory = build(:inventory, stock_quantity: -5.25)
    expect(inventory).to_not be_valid
    expect(inventory.errors[:stock_quantity]).to include("must be greater than or equal to 0")
  end
end
