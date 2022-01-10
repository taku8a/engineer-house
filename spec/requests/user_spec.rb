require 'rails_helper'

RSpec.describe "users_controllerテスト", type: :request do
  describe 'GET indexアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get index_users_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get index_users_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end

      it '正常に応答する' do
        get index_users_path
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get index_users_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET showアクションテスト' do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get show_users_path(@user)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get show_users_path(@user)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get show_users_path(@user)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get show_users_path(@user)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET editアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get edit_users_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get edit_users_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end

      it '正常に応答する' do
        get edit_users_path
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get edit_users_path
        expect(response.status).to eq 200
      end
    end
  end
end
