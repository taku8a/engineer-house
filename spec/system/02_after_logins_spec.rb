require 'rails_helper'

RSpec.describe "[STEP2]ユーザーログイン後のテスト", type: :system do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:other_post) { create(:post) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト：ログインしている場合' do
    context '表示内容の確認' do
      it 'マイページリンクが表示されて、内容が正しい' do
        expect(page).to have_link 'マイページ', href: mypage_users_path
      end
      it 'ENGINEER HOUSEリンクが表示されて、内容が正しい' do
        expect(page).to have_link 'ENGINEER HOUSE', href: root_path
      end
      it 'メンバー一覧リンクが表示されて、内容が正しい' do
        expect(page).to have_link 'メンバー一覧', href: index_users_path
      end
      it '投稿一覧リンクが表示されて、内容が正しい' do
        expect(page).to have_link '投稿一覧', href: posts_path
      end
      it 'コメント一覧リンクが表示されて、内容が正しい' do
        expect(page).to have_link 'コメント一覧', href: post_comments_all_path
      end
      it 'プロジェクト一覧リンクが表示されて、内容が正しい' do
        expect(page).to have_link 'プロジェクト一覧', href: projects_path
      end
      it 'ジャンル一覧リンクが表示されて、内容が正しい' do
        expect(page).to have_link 'ジャンル一覧', href: genres_path
      end
      it 'ガイド一覧リンクが表示されて、内容が正しい' do
        expect(page).to have_link 'ガイド一覧', href: genre_details_all_path
      end
      it 'お問い合わせリンクが表示されて、内容が正しい' do
        expect(page).to have_link 'お問い合わせ', href: new_contact_path
      end
      it 'ログアウトリンクが表示されて、内容が正しい' do
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit posts_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq posts_path
      end
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
        expect(page).to have_link post.title, href: post_path(post)
        expect(page).to have_link other_post.title, href: post_path(other_post)
      end
      it '自分の投稿と他人の投稿のオピニオンが表示される' do
        expect(page).to have_content post.short_body
        expect(page).to have_content other_post.short_body
      end
    end
  end


end
