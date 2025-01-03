require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = build(:user, name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a role" do
    user = build(:user, role: nil)
    expect(user).to_not be_valid
    expect(user.errors[:role]).to include("can't be blank")
  end

  it "is invalid with duplicate email" do
    create(:user, email: "firstemail@gmail.com")

    duplicate_user = build(:user, email: "firstemail@gmail.com")
    expect(duplicate_user).to_not be_valid
    expect(duplicate_user.errors[:email]).to include("has already been taken")
  end

  it "is invalid with wrong email formats" do
    user = build(:user, email: "firstemail-gmail.com")

    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("is invalid")
  end

  it "has secure password" do
    user = create(:user, password: "password123", password_confirmation: "password123")

    expect(user.authenticate("password123")).to eq(user)
  end

  it "requires a password with minimum 6 characters when creating a new user" do
    user = build(:user, password: "123", password_confirmation: "123")

    expect(user).to_not be_valid
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it "does not require a password when updating an existing user" do
    user = create(:user)
    user.name = "New Name"
    expect(user).to be_valid # Update without changing the password
  end
end
