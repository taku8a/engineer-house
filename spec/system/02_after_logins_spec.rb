require 'rails_helper'

RSpec.describe "[STEP2]ユーザーログイン後のテスト", type: :system do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }

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
        expect(page).to have_link post.short_title, href: post_path(post)
        expect(page).to have_link other_post.short_title, href: post_path(other_post)
      end
      it '自分の投稿と他人の投稿のオピニオンが表示される' do
        expect(page).to have_content post.short_body
        expect(page).to have_content other_post.short_body
      end
      it '自分と他人の投稿時間が表示される' do
        expect(page).to have_content post.make_time
        expect(page).to have_content other_post.make_time
      end
      it '投稿者の名前表示とその投稿者の詳細画面のリンクが正しい' do
        expect(page).to have_link post.user.short_name, href: show_users_path(post.user.id)
        expect(page).to have_link other_post.user.short_name, href: show_users_path(other_post.user.id)
      end
      it '新規投稿画面へのリンクが存在する' do
        expect(page).to have_link '', href: new_post_path
      end
    end
  end

  describe '新規投稿画面のテスト' do
    before do
      visit new_post_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq new_post_path
      end
      it '「新規投稿」と表示される' do
        expect(page).to have_content '新規投稿'
      end
      it '「タイトル」と表示される' do
        expect(page).to have_content 'タイトル'
      end
      it '「投稿内容」と表示される' do
        expect(page).to have_content '投稿内容'
      end
      it '投稿するボタンが表示される' do
        expect(page).to have_button '投稿する'
      end
      it 'titleフォームが表示される' do
        expect(page).to have_field 'post[title]'
      end
      it 'bodyフォームが表示される' do
        expect(page).to have_field 'post[body]'
      end
    end

    context '投稿成功テスト' do
      before do
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 20)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿する' }.to change{ Post.count }.by(1)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        click_button '投稿する'
        expect(current_path).to eq post_path(Post.last.id)
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit post_path(post)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq post_path(post)
      end
      it '「投稿情報」と表示される' do
        expect(page).to have_content '投稿情報'
      end
      it '「投稿者」と表示される' do
        expect(page).to have_content '投稿者'
      end
      it '「タイトル」と表示される' do
        expect(page).to have_content 'タイトル'
      end
      it '「ジャンル」と表示される' do
        expect(page).to have_content 'ジャンル'
      end
      it '「参考ガイド」と表示される' do
        expect(page).to have_content '参考ガイド'
      end
      it '「投稿内容」と表示される' do
        expect(page).to have_content '投稿内容'
      end
      it '投稿者の名前にUser詳細リンクがある' do
        expect(page).to have_link post.user.name, href: show_users_path(post.user.id)
      end
      it '投稿タイトルが表示される' do
        expect(page).to have_content post.title
      end
      it '投稿内容(body)が表示される' do
        expect(page).to have_content post.body
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '編集する', href: edit_post_path(post)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '削除する', href: post_path(post)
      end
    end

    context '投稿編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集する'
        expect(current_path).to eq edit_post_path(post)
      end
    end

    context '投稿削除リンクのテスト' do
      before do
        click_link '削除する'
      end

      it '正しく削除され、リダイレクト先が、投稿一覧画面になっている' do
        expect(Post.where(id: post.id).count).to eq 0
        expect(current_path).to eq posts_path
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq edit_post_path(post)
      end
      it '「投稿編集」と表示される' do
        expect(page).to have_content '投稿編集'
      end
      it '「ジャンル」と表示される' do
        expect(page).to have_content 'ジャンル'
      end
      it '「参考ガイド」と表示される' do
        expect(page).to have_content '参考ガイド'
      end
      it '「タイトル」と表示される' do
        expect(page).to have_content 'タイトル'
      end
      it '「投稿」と表示される' do
        expect(page).to have_content '投稿'
      end
      it 'アップデートボタンが表示される' do
        expect(page).to have_button 'アップデート'
      end
      it 'title編集フォームが表示される' do
        expect(page).to have_field 'post[title]', with: post.title
      end
      it 'body編集フォームが表示される' do
        expect(page).to have_field 'post[body]', with: post.body
      end
    end

    context '更新成功テスト' do
      before do
        @post_old_title = post.title
        @post_old_body = post.body
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 20)
        click_button 'アップデート'
      end

      it 'titleが正しく更新される' do
        expect(post.reload.title).not_to eq @post_old_title
      end
      it 'bodyが正しく更新される' do
        expect(post.reload.body).not_to eq @post_old_body
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        expect(current_path).to eq post_path(post)
      end
    end
  end
end
