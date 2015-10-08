require "rails_helper"

include LoginHelpers

RSpec.describe "Users edit", :type => :request do
  before(:each) do
    @user = create(:user)
  end

  xit "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    login_as(@user)
    name = "JDawg"
    email = "edited@example.com"
    patch user_path(@user), user: { name: name,
                                    email: email,
                                    password: "",
                                    password_confirmation: "" }

    @user.reload
    expect(@user.name).to eq("JDawg")
    expect(@user.email).to eq("editec@example.com")
  end
end
