require 'rails_helper'

RSpec.describe "genre_details_controllerのテスト", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user:@user)
    @post_comment = FactoryBot.create(:post_comment, user:@user, post:@post)
    @genre = FactoryBot.create(:genre, owner_id: @user.id)
    @genre_detail = FactoryBot.create(:genre_detail, genre:@genre)
    @project = FactoryBot.create(:project, owner_id: @user.id)
    @project.users << @user
    @project_chat = FactoryBot.create(:project_chat, user:@user, project:@project)
  end

  describe "GET indexアクションテスト" do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get genre_genre_details_path(@genre)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get genre_genre_details_path(@genre)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get genre_genre_details_path(@genre)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get genre_genre_details_path(@genre)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET showアクションテスト' do

    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get genre_genre_detail_path(@genre_detail.genre_id,@genre_detail.id)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get genre_genre_detail_path(@genre_detail.genre_id,@genre_detail.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get genre_genre_detail_path(@genre_detail.genre_id,@genre_detail.id)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get genre_genre_detail_path(@genre_detail.genre_id,@genre_detail.id)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET editアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get edit_genre_genre_detail_path(@genre_detail.genre_id,@genre_detail.id)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get edit_genre_genre_detail_path(@genre_detail.genre_id,@genre_detail.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get edit_genre_genre_detail_path(@genre_detail.genre_id,@genre_detail.id)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get edit_genre_genre_detail_path(@genre_detail.genre_id,@genre_detail.id)
        expect(response.status).to eq 200
      end
    end
  end
end
