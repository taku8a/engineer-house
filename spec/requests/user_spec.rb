require 'rails_helper'

RSpec.describe "ユーザーログイン後のコントローラーテスト", type: :request do
  describe 'GET /index' do
    # @user = create(:user)
    it 'リクエストが成功すること' do
      @user = create(:user)
      get '/index'
      expect(response.status).to eq 200
    end
  end
end
