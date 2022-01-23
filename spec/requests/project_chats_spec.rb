require 'rails_helper'

RSpec.describe "ProjectChats", type: :request do
  describe "GET /project_chats" do
    it "works! (now write some real specs)" do
      get project_chats_index_path
      expect(response).to have_http_status(200)
    end
  end
end
