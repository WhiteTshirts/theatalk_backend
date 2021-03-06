require 'rails_helper'

RSpec.describe "Dms", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/dm/show"
      expect(response).to have_http_status(:success)
    end
  end

end
