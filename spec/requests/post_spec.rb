require 'rails_helper'

RSpec.describe "posts_controllerテスト", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user:@user)
  end

  describe "GET indexアクションテスト" do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get posts_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get posts_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get posts_path
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get posts_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET showアクションテスト' do

    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get post_path(@post)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get post_path(@post)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get post_path(@post)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get post_path(@post)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET editアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get edit_post_path(@post)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get edit_post_path(@post)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get edit_post_path(@post)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get edit_post_path(@post)
        expect(response.status).to eq 200
      end
    end
  end
end
