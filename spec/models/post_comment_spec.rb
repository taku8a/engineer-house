require 'rails_helper'

RSpec.describe PostComment, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'PostCommentGenreDetailモデルとの関係' do
      it '1:Nとなっている' do
        expect(PostComment.reflect_on_association(:post_comment_genre_details).macro).to eq :has_many
      end
    end
  end
  
  describe 'バリデーションのテスト' do
    subject { post_comment.valid? }
    
    let(:post_comment) { build(:post_comment) }
    
    context 'commentカラム' do
      it '空欄でない' do
        post_comment.comment = ''
        is_expected.to eq false
      end
    end
  end
end
