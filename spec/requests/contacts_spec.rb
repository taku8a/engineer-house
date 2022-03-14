require 'rails_helper'

RSpec.describe "contacts_controllerのテスト", type: :request do

  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user:@user)
    @post_comment = FactoryBot.create(:post_comment, user:@user, post:@post)
    @genre = FactoryBot.create(:genre, owner_id: @user.id)
    @genre_detail = FactoryBot.create(:genre_detail, genre:@genre)
    @project = FactoryBot.create(:project, owner_id: @user.id)
    @project.users << @user
    @project_chat = FactoryBot.create(:project_chat, user:@user, project:@project)
    @contact = FactoryBot.create(:contact)
  end

  describe 'GET newアクションテスト' do

    context 'お問い合わせフォーム表示' do
      it '正常に応答する' do
        get new_contact_path
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get new_contact_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET completeアクションテスト' do

    context 'お問い合わせフォーム表示' do
      it '正常に応答する' do
        get complete_contacts_path
        expect(response).to be_successful
      end
      it '200レスポンスが返る' do
        get complete_contacts_path
        expect(response.status).to eq 200
      end
    end
  end
end
