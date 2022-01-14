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

  describe 'GET unsubscribeアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get unsubscribe_users_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get unsubscribe_users_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end

      it '正常に応答する' do
        get unsubscribe_users_path
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get unsubscribe_users_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET mypageアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get mypage_users_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get mypage_users_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end

      it '正常に応答する' do
        get mypage_users_path
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get mypage_users_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'Patch updateアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        patch update_users_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        patch update_users_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end

      it 'マイページを更新できる' do
        user_params = FactoryBot.attributes_for(:user, name: Faker::Name.name,introduction: Faker::Lorem.characters(number: 20),email: Faker::Internet.email)
        patch update_users_path
        get mypage_users_path
        expect(:notice).to be_present
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET searchアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get search_users_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get search_users_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
        get search_users_path,params: {content: @user.name}
      end

      it '検索が成功する' do
        expect(response.status).to eq 200
        expect(response.body).to include 'メンバー検索結果'
        expect(response).to be_successful
      end
    end
  end
end
