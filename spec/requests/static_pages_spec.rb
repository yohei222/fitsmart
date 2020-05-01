require 'rails_helper'

RSpec.feature "StaticPages", type: :request do
  describe "GET #new" do
    it "レスポンスが成功" do
      get root_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end
end