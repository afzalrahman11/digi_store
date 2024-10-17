require 'rails_helper'

RSpec.describe Debtor, type: :model do
  it "is valid with valid attributes" do
    debtor = build(:debtor)
    expect(debtor).to be_valid
  end

  it "is invalid without a name" do
    debtor = build(:debtor, name: nil)
    expect(debtor).to_not be_valid
    expect(debtor.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an phone" do
    debtor = build(:debtor, phone: nil)
    expect(debtor).to_not be_valid
    expect(debtor.errors[:phone]).to include("can't be blank")
  end

  it "is invalid without a total debt" do
    debtor = build(:debtor, total_debt: nil)
    expect(debtor).to_not be_valid
    expect(debtor.errors[:total_debt]).to include("can't be blank")
  end

  it "is invalid with duplicate phone" do
    create(:debtor, phone: "9747974797")

    duplicate_debtor = build(:debtor, phone: "9747974797")
    expect(duplicate_debtor).to_not be_valid
    expect(duplicate_debtor.errors[:phone]).to include("has already been taken")
  end

  it "is invalid with wrong phone format" do
    debtor = build(:debtor, phone: "0123456789")

    expect(debtor).to_not be_valid
    expect(debtor.errors[:phone]).to include("must be exactly 10 digits and cannot start with 0")
  end
end
