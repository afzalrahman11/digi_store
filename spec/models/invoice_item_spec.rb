require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it "is valid with valid attributes" do
    invoice_item = build(:invoice_item)
    expect(invoice_item).to be_valid
  end

  it "is invalid without a quantity" do
    invoice_item = build(:invoice_item, quantity: nil)

    expect(invoice_item).to_not be_valid
    expect(invoice_item.errors[:quantity]).to include("can't be blank")
  end

  it "is invalid without a price" do
    invoice_item = build(:invoice_item, price: nil)

    expect(invoice_item).to_not be_valid
    expect(invoice_item.errors[:price]).to include("can't be blank")
  end

  it "is invalid without an associated item" do
    invoice_item = build(:invoice_item, item: nil)

    expect(invoice_item).to_not be_valid
  end

  it "belongs to an item" do
    item = create(:item)
    invoice_item = build(:invoice_item, item: item)

    expect(invoice_item).to be_valid
  end

  it "is invalid without an associated invoice" do
    invoice_item = build(:invoice_item, invoice: nil)

    expect(invoice_item).to_not be_valid
  end

  it "belongs to an item" do
    invoice = create(:invoice)
    invoice_item = build(:invoice_item, invoice: invoice)

    expect(invoice_item).to be_valid
  end

  it "is invalid with negative values for quantity" do
    invoice_item = build(:invoice_item, quantity: -5.25)
    expect(invoice_item).to_not be_valid
    expect(invoice_item.errors[:quantity]).to include("must be greater than or equal to 0")
  end
end
