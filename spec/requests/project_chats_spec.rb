require 'rails_helper'

RSpec.describe "project_chats_controllerのテスト", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user:@user)
    @genre = FactoryBot.create(:genre, owner_id: @user.id)
    @project = FactoryBot.create(:project, owner_id: @user.id)
    @project.users << @user
    @project_chat = FactoryBot.create(:project_chat, user:@user, project:@project)
  end

  describe "GET indexアクションテスト" do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        get project_project_chats_path(@project)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        get project_project_chats_path(@project)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '正常に応答する' do
        get project_project_chats_path(@project)
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get project_project_chats_path(@project)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST createアクションテスト' do
    context 'ユーザーがログインしていない時' do
      it '302レスポンスが返る' do
        post project_project_chats_path(@project)
        expect(response.status).to eq 302
      end
      it 'ログイン画面にリダイレクトされる' do
        post project_project_chats_path(@project)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ユーザーがログインしているとき' do
      before do
        sign_in @user
      end

      it '新規投稿する' do
        project_chat_params = FactoryBot.attributes_for(:project_chat)
        expect do
          post project_project_chats_path(@project), params: { project_chat: project_chat_params }, xhr: true
        end
        get project_project_chats_path(@project)
        expect(:notice).to be_present
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end
  end
end
