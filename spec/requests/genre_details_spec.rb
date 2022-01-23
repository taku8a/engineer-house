require 'rails_helper'

RSpec.describe "GenreDetails", type: :request do
  describe "GET /genre_details" do
    it "works! (now write some real specs)" do
      get genre_details_path
      expect(response).to have_http_status(200)
    end
  end
end
