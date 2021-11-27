require 'rails_helper'

RSpec.describe ProjectChat, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(ProjectChat.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Projectモデルとの関係' do
      it 'N:1となっている' do
        expect(ProjectChat.reflect_on_association(:project).macro).to eq :belongs_to
      end
    end
  end
  
  describe 'バリデーションのテスト' do
    subject { project_chat.valid? }
    
    let(:project_chat) { build(:project_chat) }
    
    context 'chatカラム' do
      it '空欄でない' do
        project_chat.chat = ''
        is_expected.to eq false
      end
    end
  end
end
