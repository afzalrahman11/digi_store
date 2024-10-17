require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with valid attributes" do
      category = build(:category)
      expect(category).to be_valid
    end

  it "is invalid without a name" do
    category = build(:category, name: nil)
    expect(category).to_not be_valid
    expect(category.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a unit" do
    category = build(:category, unit: nil)
    expect(category).to_not be_valid
    expect(category.errors[:unit]).to include("can't be blank")
  end

  it "is invalid with duplicate names" do
    create(:category, name: "First category")

    duplicate_category = build(:category, name: "First category")
    expect(duplicate_category).to_not be_valid
    expect(duplicate_category.errors[:name]).to include("has already been taken")
  end

  it "is invalid with duplicate units" do
    create(:category, unit: "First Unit")

    duplicate_category = build(:category, unit: "First Unit")
    expect(duplicate_category).to_not be_valid
    expect(duplicate_category.errors[:unit]).to include("has already been taken")
  end

  it "has many items" do
    category = create(:category)
    item1 = create(:item, category: category)
    item2 = create(:item, category: category)
    item3 = create(:item, category: category)

    expect(category.items).to include(item1, item2, item3)
  end
end
