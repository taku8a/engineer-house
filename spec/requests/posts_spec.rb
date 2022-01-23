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

  describe 'PATCH updateアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        patch post_path(@post)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        patch post_path(@post)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it 'マイ投稿を更新できる' do
        post_params = FactoryBot.attributes_for(:post, title: Faker::Lorem.characters(number: 10),body: Faker::Lorem.characters(number: 20))
        patch post_path(@post),params: { id: @post.id,post: post_params }
        get post_path(@post)
        expect(:notice).to be_present
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET newアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get new_post_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get new_post_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get new_post_path
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get new_post_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST createアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        post posts_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        post posts_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '新規投稿する' do
        post_params = FactoryBot.attributes_for(:post)
        expect post posts_path, params: { post: post_params }
        get post_path(@post)
        expect(:notice).to be_present
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET searchアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get search_posts_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get search_posts_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
        get search_posts_path,params: { content: @post.title }
      end

      it '検索が成功する' do
        expect(response.status).to eq 200
        expect(response.body).to include '投稿検索結果'
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE destroyアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        delete post_path(@post)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        delete post_path(@post)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it 'マイ投稿を削除する' do
        expect {
          delete post_path(@post)
        }.to change(@user.posts, :count).by(-1)
        get posts_path
        expect(:notice).to be_present
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end
  end
end
