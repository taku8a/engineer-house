require 'rails_helper'

RSpec.describe PostGenreDetail, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(PostGenreDetail.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    context 'GenreDetailモデルとの関係' do
      it 'N:1となっている' do
        expect(PostGenreDetail.reflect_on_association(:genre_detail).macro).to eq :belongs_to
      end
    end
  end
end
