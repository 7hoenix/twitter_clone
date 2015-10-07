require 'rails_helper'

RSpec.describe UsersController do
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    context "when a user exists" do
      it "opens the edit page with the user data in the table" do
        user = create(:user)

        get :edit, id: user.id

        expect(response.status).to eq 200
      end
    end

  xdescribe "POST #update" do
      it "updates the user with a new email address" do
        user = create(:user)

        patch :update, user: { email: "edited@example.com", password:
          user.password }

        expect(response).to redirect_to user
        expect(user.email).to eq("edited@example.com")
      end
    end
  end
end
