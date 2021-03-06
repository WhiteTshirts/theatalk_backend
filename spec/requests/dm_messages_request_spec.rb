require 'rails_helper'

RSpec.describe "DmMessages", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/dm_messages/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/dm_messages/create"
      expect(response).to have_http_status(:success)
    end
  end

end
