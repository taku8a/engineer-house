require 'rails_helper'

RSpec.describe "homes_controllerテスト", type: :request do
  describe "GET topアクションテスト" do
    it 'リクエストが成功すること' do
      get root_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET aboutアクションテスト' do
    it 'リクエストが成功すること' do
      get about_path
      expect(response.status).to eq 200
    end
  end
end
