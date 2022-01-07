require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
      let(:user) { create(:user) }
      let!(:post) { create(:post, user: user) }
    end
  describe "GET /index" do

    # before do
    #   let(:user) { create(:user) }
    #   let!(:post) { create(:post, user: user) }
    # end
    it 'リクエストが成功すること' do
      get '/index'
      expect(response.status).to eq 200
    end
  end
end
