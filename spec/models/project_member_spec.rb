require 'rails_helper'

RSpec.describe ProjectMember, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(ProjectMember.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Projectモデルとの関係' do
      it 'N:1となっている' do
        expect(ProjectMember.reflect_on_association(:project).macro).to eq :belongs_to
      end
    end
  end
end
