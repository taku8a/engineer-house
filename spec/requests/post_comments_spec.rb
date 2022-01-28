require 'rails_helper'

RSpec.describe "posts_comment_controllerのテスト", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user:@user)
    @post_comment = FactoryBot.create(:post_comment, user:@user, post:@post)
  end

  describe "GET indexアクションテスト" do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get post_post_comments_path(@post_comment.post_id)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get post_post_comments_path(@post_comment.post_id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get post_post_comments_path(@post_comment.post_id)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get post_post_comments_path(@post_comment.post_id)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET showアクションテスト' do

    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get post_post_comment_path(@post_comment.post_id,@post_comment.id)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get post_post_comment_path(@post_comment.post_id,@post_comment.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get post_post_comment_path(@post_comment.post_id,@post_comment.id)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get post_post_comment_path(@post_comment.post_id,@post_comment.id)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET editアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get edit_post_post_comment_path(@post_comment.post_id,@post_comment.id)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get edit_post_post_comment_path(@post_comment.post_id,@post_comment.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get edit_post_post_comment_path(@post_comment.post_id,@post_comment.id)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get edit_post_post_comment_path(@post_comment.post_id,@post_comment.id)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'PATCH updateアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        patch post_post_comment_path(@post_comment.post_id,@post_comment.id)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        patch post_post_comment_path(@post_comment.post_id,@post_comment.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it 'マイコメントを更新できる' do
        post_comment_params = FactoryBot.attributes_for(:post_comment, user: @user,comment: Faker::Lorem.characters(number: 20))
        patch post_post_comment_path(@post_comment.post_id,@post_comment.id),params: { id: @post_comment.id,post_comment: post_comment_params }
        get post_post_comment_path(@post_comment.post_id,@post_comment.id)
        expect(:notice).to be_present
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET newアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get new_post_post_comment_path(@post_comment.post_id)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get new_post_post_comment_path(@post_comment.post_id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get new_post_post_comment_path(@post_comment.post_id)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get new_post_post_comment_path(@post_comment.post_id)
        expect(response.status).to eq 200
      end
    end
  end
end
