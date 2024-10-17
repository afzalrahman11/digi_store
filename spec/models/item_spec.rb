require 'rails_helper'

RSpec.describe Item, type: :model do
  it "is valid with valid attributes" do
    item = build(:item)
    expect(item).to be_valid
  end

  it "is invalid without a name" do
    item = build(:item, name: nil)
    expect(item).to_not be_valid
    expect(item.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a unit" do
    item = build(:item, unit: nil)
    expect(item).to_not be_valid
    expect(item.errors[:unit]).to include("can't be blank")
  end

  it "is invalid without a price" do
    item = build(:item, price: nil)
    expect(item).to_not be_valid
    expect(item.errors[:price]).to include("can't be blank")
  end

  it "is invalid without a quantity" do
    item = build(:item, quantity: nil)
    expect(item).to_not be_valid
    expect(item.errors[:quantity]).to include("can't be blank")
  end

  it "is invalid with duplicate names" do
    create(:item, name: "First Item")

    duplicate_item = build(:item, name: "First Item")
    expect(duplicate_item).to_not be_valid
    expect(duplicate_item.errors[:name]).to include("has already been taken")
  end

  it "is invalid with duplicate units" do
    create(:item, unit: "First Unit")

    duplicate_item = build(:item, unit: "First Unit")
    expect(duplicate_item).to_not be_valid
    expect(duplicate_item.errors[:unit]).to include("has already been taken")
  end

  it "is invalid with negative quantity" do
    item = build(:item, quantity: -1)

    expect(item).to_not be_valid
    expect(item.errors[:quantity]).to include("must be greater than or equal to 0")
  end

  it "is invalid with negative price" do
    item = build(:item, price: -25.12)

    expect(item).to_not be_valid
    expect(item.errors[:price]).to include("must be greater than or equal to 0")
  end

  it "belongs to a category" do
    category = create(:category)

    item = build(:item, category: category)
    expect(item.category).to eq(category)
  end
end
