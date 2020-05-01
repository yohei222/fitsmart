require 'rails_helper'

RSpec.describe "User pages", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  before do
    def sign_in_as(user)
      post login_path, params: { session: { email: user.email, password: user.password } }
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get signup_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #show" do
    context "as an authenticated user" do
      it "responds successfully" do
        sign_in_as user
        get user_path(user)
        expect(response).to be_success
        expect(response).to have_http_status "200"
      end
    end

    context "as a guest" do
      it "redirects to the login page" do
        get user_path(user)
        expect(response).to be_success
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#edit" do
    context "as an authorized user" do
      it "responds successfully" do
        sign_in_as user
        get edit_user_path(user)
        expect(response).to be_success
        expect(response).to have_http_status "200"
      end
    end

    context "as a guest" do
      it "redirects to the login page" do
        get edit_user_path(user)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

    context "as other user" do
      it "redirects to the login page" do
        sign_in_as other_user
        get edit_user_path(user)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      it "updates a user" do
        user_params = FactoryBot.attributes_for(:user, name: "NewName", sex: "man", status: "released")
        sign_in_as user
        user.name = "NewName"
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq "NewName"
      end
    end

    context "as a guest" do
      it "redirects to the login page" do
        user_params = FactoryBot.attributes_for(:user, name: "NewName")
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

    context "as other user" do
      it "does not update the user" do
        user_params = FactoryBot.attributes_for(:user, name: "NewName")
        sign_in_as other_user
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq other_user.name
      end

      it "redirects to the login page" do
        user_params = FactoryBot.attributes_for(:user, name: "NewName")
        sign_in_as other_user
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      it "deletes a user" do
        sign_in_as user
        delete user_path(user), params: { id: user.id }
        expect(response).to redirect_to root_path
      end
    end

    context "as au unauthorized user" do
      it "redirects to the dashboard" do
        sign_in_as other_user
        delete user_path(user), params: { id: user.id }
        expect(response).to redirect_to root_path
      end
    end

    context "as a guest" do
      it "returns a 302 response" do
        delete user_path(user), params: { id: user.id }
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        delete user_path(user), params: { id: user.id }
        expect(response).to redirect_to login_path
      end
    end
  end

end