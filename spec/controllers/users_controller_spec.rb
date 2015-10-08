require 'rails_helper'

include LoginHelpers

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

        login(user)
        get :edit, id: user.id

        expect(response.status).to eq 200
        expect(response).to render_template(:edit)
      end
    end

    context "should redirect edit when logged in as wrong user" do
        it "when logged in as a different user" do
        justin = create(:user, name: "Justin")
        archer = create(:user, name: "Archer")

        login(justin)
        get :edit, id: archer.id

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the user with a new email address" do
        user = create(:user)

        login(user)
        patch :update, id: user, user: { email: "edited@example.com", password:
          user.password }

        expect(response).to redirect_to user
        user.reload
        expect(user.email).to eq("edited@example.com")
      end
    end

    context "with invalid attributes" do
      it "redirects to the edit page" do
        user = create(:user)

        login(user)
        patch :update, id: user, user: { email: "edited.com", password:
          user.password }

        expect(response).to render_template :edit
        expect(user.email).to_not eq("edited.com")
        expect(flash[:error]).to match(/^Invalid email\/password combination/)
      end
    end

    context "when logged in with a different user" do
      it "redirects to root" do
        justin = create(:user, name: "Justin")
        archer = create(:user, name: "Archer")

        login(justin)
        patch :update, id: archer, user: { email: "edited.com", password:
          justin.password }

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #index" do
    it "should redirect index when not logged in" do
      get :index
      expect(response).to redirect_to(login_path)
    end
  end
end
