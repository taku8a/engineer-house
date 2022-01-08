require 'rails_helper'

RSpec.describe "homes_controllerのテスト", type: :request do
  describe "GET /" do
    it 'リクエストが成功すること' do
      get root_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET /about' do
    it 'リクエストが成功すること' do
      get about_path
      expect(response.status).to eq 200
    end
  end
end
