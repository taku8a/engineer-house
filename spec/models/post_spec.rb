require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'アソシエーションのテスト' do
    context 'PostGenreモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_genres).macro).to eq :has_many
      end
    end
    context 'PostGenreDetailモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_genre_details).macro).to eq :has_many
      end
    end
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
  
  describe 'バリデーションのテスト' do
    subject { post.valid? }
    
    let(:post) { build(:post) }
    
    context 'titleカラム' do
      it '空欄でない' do
        post.title = ''
        is_expected.to eq false
      end
    end
    
    context 'bodyカラム' do
      it '空欄でない' do
        post.body = ''
        is_expected.to eq false
      end
    end
  end
end
