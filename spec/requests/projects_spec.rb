require 'rails_helper'

RSpec.describe "projects_controllerのテスト", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user:@user)
    @genre = FactoryBot.create(:genre, owner_id: @user.id)
    @project = FactoryBot.create(:project, owner_id: @user.id)
  end

  describe "GET indexアクションテスト" do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get projects_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get projects_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get projects_path
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get projects_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET showアクションテスト' do

    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get project_path(@project)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get project_path(@project)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get project_path(@project)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get project_path(@project)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET editアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get edit_project_path(@project)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get edit_project_path(@project)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get edit_project_path(@project)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get edit_project_path(@project)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'PATCH updateアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        patch project_path(@project)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        patch project_path(@project)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it 'マイプロジェクトを更新できる' do
        project_params = FactoryBot.attributes_for(:project, name: Faker::Lorem.characters(number: 10),introduction: Faker::Lorem.characters(number: 20))
        patch project_path(@project),params: { id: @project.id,project: project_params }
        get project_path(@project)
        expect(:notice).to be_present
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET newアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get new_project_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get new_project_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get new_project_path
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get new_project_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST createアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        post projects_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        post projects_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '新規投稿する' do
        project_params = FactoryBot.attributes_for(:project, owner_id: @user.id)
        expect post projects_path, params: { project: project_params }
        get project_path(@project)
        expect(:notice).to be_present
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET searchアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get search_projects_path
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get search_projects_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
        get search_projects_path,params: { content: @project.name }
      end

      it '検索が成功する' do
        expect(response.status).to eq 200
        expect(response.body).to include 'プロジェクト検索結果'
        expect(response).to be_successful
      end
    end
  end
end
