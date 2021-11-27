require 'rails_helper'

RSpec.describe GenreDetail, type: :model do
  describe 'アソシエーションのテスト' do
    context 'PostGenreDetailモデルとの関係' do
      it '1:Nとなっている' do
        expect(GenreDetail.reflect_on_association(:post_genre_details).macro).to eq :has_many
      end
    end
    context 'PostCommentGenreDetailモデルとの関係' do
      it '1:Nとなっている' do
        expect(GenreDetail.reflect_on_association(:post_comment_genre_details).macro).to eq :has_many
      end
    end
    context 'Genreモデルとの関係' do
      it 'N:1となっている' do
        expect(GenreDetail.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end
  end
  
  describe 'バリデーションのテスト' do
    subject { genre_detail.valid? }
    
    let(:genre_detail) { build(:genre_detail) }
    
    context 'titleカラム' do
      it '空欄でない' do
        genre_detail.title = ''
        is_expected.to eq false
      end
    end
    
    context 'bodyカラム' do
      it '空欄でない' do
        genre_detail.body = ''
        is_expected.to eq false
      end
    end
  end
end
