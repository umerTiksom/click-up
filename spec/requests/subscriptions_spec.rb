require 'rails_helper'

RSpec.describe "Subcriptions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/subscriptions/new"
      expect(response).to have_http_status(:success)
    end
  end

end
