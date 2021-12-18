require 'rails_helper'

RSpec.describe "[STEP2]ユーザーログイン後のテスト", type: :system do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }
  let!(:post_comment) { create(:post_comment, user: user, post: post) }
  let!(:other_post_comment) { create(:post_comment, user: other_user, post: post) }
  let!(:genre) { create(:genre, owner_id: user.id) }
  let!(:other_genre) { create(:genre, owner_id: other_user.id) }

  # なぜ、let(:post) { create(:post) }ではダメなのか？　association :userが効いているから良いのでは？
  # →ログインユーザーの投稿ではない為。association :userはpostデータ作成時にuserデータも生成する。つまり、ここでは、ログインユーザー
  # とは別で新たなユーザーが生成されるため、post.userとuserは別の人という事になる。編集・削除権限がある詳細画面などで、うまくいかない
  # ため、上記のように記述する。

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  
  describe 'ジャンル一覧・新規登録画面のテスト', js: true do
  # describe 'ジャンル一覧・新規登録画面のテスト' do
    before do
      visit genres_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq genres_path
      end
      it '自分のジャンルと他人のジャンルの投稿数のリンク先がそれぞれ正しい' do
        expect(page).to have_link genre.posts.count, href: genre_path(genre)
        expect(page).to have_link other_genre.posts.count, href: genre_path(other_genre)
      end
      it '自分のジャンル名と他人のジャンル名がそれぞれ表示される' do
        expect(page).to have_content genre.short_name
        expect(page).to have_content other_genre.short_name
      end
      it '「ジャンル一覧・追加」と表示される' do
        expect(page).to have_content 'ジャンル一覧・追加'
      end
      it '「ジャンル」と表示される' do
        expect(page).to have_content 'ジャンル'
      end
      it '「投稿数」と表示される' do
        expect(page).to have_content '投稿数'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
      it 'name登録フォームが表示される' do
        expect(page).to have_field 'genre[name]'
      end
      it '自分のジャンルガイドが表示される' do
        expect(page).to have_link 'ジャンルガイド'
      end
      it '自分のジャンルの編集リンクが表示される' do
        p page.body
        expect(page).to have_link '編集する'#, href: edit_genre_path(genre)
      end
    end

    context 'ジャンル登録成功テスト'do
      before do
        fill_in 'genre[name]', with: Faker::Lorem.characters(number: 10)
      end

      it '自分の新しいジャンルが正しく保存される', js: true do
        # expect { click_button '新規登録' }.to change{ Genre.count }.by(1) X
        # Ajaxが終わっていないのに、Ajaxの結果をチェックしてしまうので、
        # モデルを直接テストせず、sleep(3)で待ってから、ブラウザ表示をテストするようにした。
        click_button '新規登録'
        sleep(3)
        expect(page).to have_content '登録しました。'
      end
      it 'レンダー先が、保存できたジャンルの一覧・新規登録画面になっている', js: true do
        click_button '新規登録'
        sleep(3)
        expect(current_path).to eq genres_path
      end
    end
  end
end