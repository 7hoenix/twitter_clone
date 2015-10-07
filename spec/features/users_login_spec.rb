require "rails_helper"

RSpec.feature "user logs in" do
  before(:each) { @user = User.create(name: "Justin",
                              email: "user@example.com",
                              password: "password") }

  it "with valid credentials" do
    visit login_path
    fill_in("Email", with: "user@example.com")
    fill_in("Password", with: "password")
    click_on("Log in")

    expect(current_path).to eq(user_path(@user))

    click_on("Logout")
    expect(current_path).to eq(root_path)
    page.driver.submit :delete, "/logout", {}
    expect(current_path).to eq(root_path)
  end
end
