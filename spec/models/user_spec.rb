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
    
    # buildメソッドはメモリ上にインスタンスを確保。createメソッドはデータ保存＋モデルのインスタンス生成も同時に行い、かつ返り値は、
    # 生成されたインスタンスが返る。よって、保存に失敗してもモデルのインスタンスを返すため、評価はnil,''ともに
    # trueとなる。つまり、ここでの２つの検証は意味がないが、勉強になったため、記述した。（other_user）
    
    context 'is_validカラム' do
      it 'nilでない' do
        user.is_valid = nil
        is_expected.to eq false
      end
      it 'nilである' do
        other_user.is_valid = nil
        is_expected.to eq true
      end
      it '空欄でない' do
        user.is_valid = ''
        is_expected.to eq false
      end
      it '空欄である' do
        other_user.is_valid = ''
        is_expected.to eq true
      end
      it '退会済みである' do
        user.is_valid = false
        is_expected.to eq true
      end
      it '有効である' do
        other_user.is_valid = true
        is_expected.to eq true
      end
    end
  end
end
