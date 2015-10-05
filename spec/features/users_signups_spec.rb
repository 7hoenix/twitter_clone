require 'rails_helper'

RSpec.feature "UsersSignups" do
  let(:count) { User.count }

  describe "signing up with invalid information" do
    it "should not work and should go back to the signup form" do
      visit signup_path
      pre_count = count
      fill_in("Name", with: "")
      fill_in("Email", with: "user@example.com")
      fill_in("Password", with: "password")
      fill_in("Confirmation", with: "password")
      click_on("Create my account")

      expect(count).to eq(pre_count)
    end
  end

  describe "signing up with valid information" do
    it "should work and redirect to the users show page" do
      visit signup_path
      pre_count = count
      fill_in("Name", with: "Justin")
      fill_in("Email", with: "user@example.com")
      fill_in("Password", with: "password")
      fill_in("Confirmation", with: "password")
      click_on("Create my account")

      expect(User.count).to_not eq(pre_count)
      expect(current_path).to eq(user_path(User.last))
    end
  end
end
