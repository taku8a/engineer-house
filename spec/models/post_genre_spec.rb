require 'rails_helper'

RSpec.describe PostGenre, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(PostGenre.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    context 'Genreモデルとの関係' do
      it 'N:1となっている' do
        expect(PostGenre.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end
  end
end
