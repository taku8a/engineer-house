require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'アソシエーションのテスト' do
    context 'PostGenreモデルとの関係' do
      it '1:Nとなっている' do
        expect(Genre.reflect_on_association(:post_genres).macro).to eq :has_many
      end
    end
    context 'GenreDetailモデルとの関係' do
      it '1:Nとなっている' do
        expect(Genre.reflect_on_association(:genre_details).macro).to eq :has_many
      end
    end
  end
  
  describe 'バリデーションのテスト' do
    subject { genre.valid? }

    let!(:other_genre) { create(:genre) }
    let(:genre) { build(:genre) }
    
    context 'nameカラム' do
      it '空欄でない' do
        genre.name = ''
        is_expected.to eq false
      end
      it '一意性がある' do
        genre.name = other_genre.name
        is_expected.to eq false
      end
    end
  end
end
