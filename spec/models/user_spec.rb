require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
  end
  
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }
    
    context 'nameカラム' do
      it '空欄でない' do
        user.name = ''
        is_expected.to eq false
      end
      it '一意性がある' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end
    
    context 'introductionカラム' do
      it '空欄でない' do
        user.introduction = ''
        is_expected.to eq false
      end
    end
    
    context 'emailカラム' do
      it '空欄でない' do
        user.email = ''
        is_expected.to eq false
      end
      it '一意性がある' do
        user.email = other_user.email
        is_expected.to eq false
      end
    end
    
    context 'is_validカラム' do
      it { is_expected.to allow_value(true).for(:is_valid) }
      it { is_expected.to allow_value(false).for(:is_valid) }
      it { is_expected.not_to allow_value(nil).for(:is_valid) }
    end
  end
end
