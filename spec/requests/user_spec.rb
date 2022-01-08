require 'rails_helper'

RSpec.describe "users_controller ", type: :request do
  describe 'GET /index' do
    context 'as a user not to login' do
      it 'returns a 302 response' do
        get index_users_path
        expect(response.status).to eq 302
      end
      it 'redirect to the sign-in page' do
        get index_users_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
      end
      
      it 'respond successfully' do
        sign_in @user
        get index_users_path
        expect(response).to be_successful
      end
      it 'returns a 200 response' do
        sign_in @user
        get index_users_path
        expect(response.status).to eq 200
      end
    end
  end
end
