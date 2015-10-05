require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: "Isaiah Lykosh", email: "Isaiah@example.com",
      password: "password", password_confirmation: "password")
  end

  it "should be valid" do
    expect(@user).to be_valid
  end

  it "should have a name" do
    @user.name = ""
    expect(@user).to_not be_valid
  end

  it "should have an email" do
    @user.email = ""
    expect(@user).to_not be_valid
  end

  it "shouldn't have too long of a name" do
    @user.name = "a" * 51
    expect(@user).to_not be_valid
  end

  it "shouldn't have too long of an email" do
    @user.email = "a" * 244 + "@example.com"
    expect(@user).to_not be_valid
  end

  it "should have a valid email address" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      expect(@user).to be_valid
    end
  end

  it "should reject invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
      foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      expect(@user).to_not be_valid
    end
  end

  it "should have a unique email address" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).to_not be_valid
  end

  it "should have a password with a value (non-blank)" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user).to_not be_valid
  end

  it "should have a password length of 6 or greater" do
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user).to_not be_valid
  end
end
