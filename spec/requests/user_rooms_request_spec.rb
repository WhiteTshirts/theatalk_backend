require 'rails_helper'

RSpec.describe "UserRooms", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/user_rooms/new"
      expect(response).to have_http_status(:success)
    end
  end

end
