require 'rails_helper'

RSpec.describe "ユーザーログイン後のコントローラーテスト", type: :request do
  describe 'GET /index' do
    let(:user) { create(:user) }
    it 'リクエストが成功すること' do
      get '/index'
      expect(response.status).to eq 200
    end
  end
end
