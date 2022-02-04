require 'rails_helper'

RSpec.describe "genre_controllerのテスト", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user:@user)
    @genre = FactoryBot.create(:genre, owner_id: @user.id)
  end

  describe "GET indexアクションテスト" do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get genres_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get genres_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get genres_path
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get genres_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET showアクションテスト' do

    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get genre_path(@genre)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get genre_path(@genre)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get genre_path(@genre)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get genre_path(@genre)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET editアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get edit_genre_path(@genre)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get edit_genre_path(@genre)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get edit_genre_path(@genre)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get edit_genre_path(@genre)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'PATCH updateアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        patch genre_path(@genre)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        patch genre_path(@genre)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it 'マイコメントを更新できる' do
        genre_params = FactoryBot.attributes_for(:genre, name: Faker::Lorem.characters(number: 10))
        patch genre_path(@genre),params: { id: @genre.id,genre: genre_params }
        get genre_path(@genre)
        expect(:notice).to be_present
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end
  end
end
