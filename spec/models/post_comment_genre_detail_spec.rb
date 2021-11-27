require 'rails_helper'

RSpec.describe PostCommentGenreDetail, type: :model do
  describe 'アソシエーションのテスト' do
    context 'GenreDetailモデルとの関係' do
      it 'N:1となっている' do
        expect(PostCommentGenreDetail.reflect_on_association(:genre_detail).macro).to eq :belongs_to
      end
    end
    context 'PostCommentモデルとの関係' do
      it 'N:1となっている' do
        expect(PostCommentGenreDetail.reflect_on_association(:post_comment).macro).to eq :belongs_to
      end
    end
  end
end
