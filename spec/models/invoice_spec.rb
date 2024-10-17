require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it "is valid with valid attributes" do
    invoice = build(:invoice)
    expect(invoice).to be_valid
  end

  it "is invalid without a payment status" do
    invoice = build(:invoice, payment_status: nil)
    expect(invoice).to_not be_valid
    expect(invoice.errors[:payment_status]).to include("can't be blank")
  end

  it "is invalid without a total_amount" do
    invoice = build(:invoice, total_amount: nil)
    expect(invoice).to_not be_valid
    expect(invoice.errors[:total_amount]).to include("can't be blank")
  end

  it "is invalid without a date" do
    invoice = build(:invoice, date: nil)
    expect(invoice).to_not be_valid
    expect(invoice.errors[:date]).to include("can't be blank")
  end

  it "is invalid for total amount with negative values" do
    invoice = build(:invoice, total_amount: -25.25)
    expect(invoice).to_not be_valid
    expect(invoice.errors[:total_amount]).to include("must be greater than or equal to 0")
  end

  it "allows setting and getting payment statuses" do
    invoice = build(:invoice, payment_status: "paid")

    expect(invoice.paid?).to be_truthy
    expect(invoice.debt?).to be_falsey
  end

  it "is invalid with future dates" do
    invoice = build(:invoice, date: DateTime.now + 1.day)

    expect(invoice).to_not be_valid
    expect(invoice.errors[:date]).to include("can't be in future")
  end
end
