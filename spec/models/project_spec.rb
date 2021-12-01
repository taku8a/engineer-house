require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Project.reflect_on_association(:users).macro).to eq :has_many
      end
    end
    context 'ProjectMemberモデルとの関係' do
      it '1:Nとなっている' do
        expect(Project.reflect_on_association(:project_members).macro).to eq :has_many
      end
    end
    context 'ProjectChatモデルとの関係' do
      it '1:Nとなっている' do
        expect(Project.reflect_on_association(:project_chats).macro).to eq :has_many
      end
    end
  end
  
  describe 'バリデーションのテスト' do
    subject { project.valid? }
    
    let(:project) { build(:project) }
    
    context 'nameカラム' do
      it '空欄でない' do
        project.name = ''
        is_expected.to eq false
      end
    end
    
    context 'introductionカラム' do
      it '空欄でない' do
        project.introduction = ''
        is_expected.to eq false
      end
    end
  end
end
