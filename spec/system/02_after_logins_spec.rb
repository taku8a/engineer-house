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
  let!(:genre_detail) { create(:genre_detail, genre: genre) }
  let!(:other_genre_detail) { create(:genre_detail, genre: other_genre) }
  let!(:project) { create(:project, owner_id: user.id) }
  let!(:other_project) { create(:project, owner_id: other_user.id) }

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

  describe 'コメント一覧画面のテスト' do
    before do
      visit post_post_comments_path(post_comment.post_id)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq post_post_comments_path(post_comment.post_id)
      end
      it '自分のコメントと他人の投稿のコメントのリンク先がそれぞれ正しい' do
        expect(page).to have_link post_comment.short_comment, href: post_post_comment_path(post_comment.post_id, post_comment.id)
        expect(page).to have_link other_post_comment.short_comment, href: post_post_comment_path(other_post_comment.post_id, other_post_comment.id)
      end
      it '自分と他人のコメント時間が表示される' do
        expect(page).to have_content post_comment.make_time
        expect(page).to have_content other_post_comment.make_time
      end
      it 'コメント者の名前表示とそのコメント者の詳細画面のリンクが正しい' do
        expect(page).to have_link post_comment.user.short_name, href: show_users_path(post_comment.user.id)
        expect(page).to have_link other_post_comment.user.short_name, href: show_users_path(other_post_comment.user.id)
      end
      it '新規投稿画面へのリンクが存在する' do
        expect(page).to have_link '', href: new_post_post_comment_path(post_comment.post_id)
      end
      it '「コメント日時」と表示される' do
        expect(page).to have_content 'コメント日時'
      end
      it '「コメント者」と表示される' do
        expect(page).to have_content 'コメント者'
      end
      it '「コメント」と表示される' do
        expect(page).to have_content 'コメント'
      end
      it '「コメント一覧」と表示される' do
        expect(page).to have_content 'コメント一覧'
      end
    end
  end

  describe '新規コメント画面のテスト' do
    before do
      visit new_post_post_comment_path(post_comment.post_id)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq new_post_post_comment_path(post_comment.post_id)
      end
      it 'コメント新規投稿' do
        expect(page).to have_content 'コメント新規投稿'
      end
      it '参考ガイド' do
        expect(page).to have_content '参考ガイド'
      end
      it 'コメント' do
        expect(page).to have_content 'コメント'
      end
      it 'コメントするボタンが表示される' do
        expect(page).to have_button 'コメントする'
      end
      it 'comment投稿フォームが表示される' do
        expect(page).to have_field 'post_comment[comment]'
      end
    end

    context 'コメント成功テスト' do
      before do
        fill_in 'post_comment[comment]', with: Faker::Lorem.characters(number: 20)
      end

      it '自分の新しいコメントが正しく保存される' do
        expect { click_button 'コメントする' }.to change{ PostComment.count }.by(1)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        click_button 'コメントする'
        expect(current_path).to eq post_post_comment_path(PostComment.last.post_id,PostComment.last.id)
      end
    end
  end

  describe '自分のコメント詳細画面のテスト' do
    before do
      visit post_post_comment_path(post_comment.post_id, post_comment.id)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq post_post_comment_path(post_comment.post_id, post_comment.id)
      end
      it '「コメント情報」と表示される' do
        expect(page).to have_content 'コメント情報'
      end
      it '「コメント者」と表示される' do
        expect(page).to have_content 'コメント者'
      end
      it '「投稿タイトル」と表示される' do
        expect(page).to have_content '投稿タイトル'
      end
      it '「参考ガイド」と表示される' do
        expect(page).to have_content '参考ガイド'
      end
      it '「コメント」と表示される' do
        expect(page).to have_content 'コメント'
      end
      it 'コメント者の名前にUser詳細リンクがある' do
        expect(page).to have_link post_comment.user.name, href: show_users_path(post_comment.user.id)
      end
      it '投稿タイトルのタイトルに投稿詳細リンクがある' do
        expect(page).to have_link post_comment.post.title, href: post_path(post_comment.post.id)
      end
      it 'コメント内容(comment)が表示される' do
        expect(page).to have_content post_comment.comment
      end
      it 'コメントの編集リンクが表示される' do
        expect(page).to have_link '編集する', href: edit_post_post_comment_path(post_comment.post_id, post_comment.id)
      end
      it 'コメントの削除リンクが表示される' do
        expect(page).to have_link '削除する', href: post_post_comment_path(post_comment.post_id, post_comment.id)
      end
    end

    context 'コメント編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集する'
        expect(current_path).to eq edit_post_post_comment_path(post_comment.post_id, post_comment.id)
      end
    end

    context '投稿削除リンクのテスト' do
      before do
        click_link '削除する'
      end

      it '正しく削除され、リダイレクト先が、コメント一覧画面になっている' do
        expect(PostComment.where(id: post_comment.id).count).to eq 0
        expect(current_path).to eq post_post_comments_path(post_comment.post_id)
      end
    end
  end

  describe '自分のコメント編集画面のテスト' do
    before do
      visit edit_post_post_comment_path(post_comment.post_id, post_comment.id)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq edit_post_post_comment_path(post_comment.post_id, post_comment.id)
      end
      it '「コメント編集」と表示される' do
        expect(page).to have_content 'コメント編集'
      end
      it '「参考ガイド」と表示される' do
        expect(page).to have_content '参考ガイド'
      end
      it '「コメント」と表示される' do
        expect(page).to have_content 'コメント'
      end
      it 'アップデートボタンが表示される' do
        expect(page).to have_button 'アップデート'
      end
      it 'comment編集フォームが表示される' do
        expect(page).to have_field 'post_comment[comment]', with: post_comment.comment
      end
    end

    context '更新成功テスト' do
      before do
        @post_comment_old_comment = post_comment.comment
        fill_in 'post_comment[comment]', with: Faker::Lorem.characters(number: 20)
        click_button 'アップデート'
      end

      it 'commentが正しく更新される' do
        expect(post_comment.reload.comment).not_to eq @post_comment_old_comment
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        expect(current_path).to eq post_post_comment_path(post_comment.post_id, post_comment.id)
      end
    end
  end

  describe '自分のジャンル詳細画面のテスト' do
    before do
      visit genre_path(genre)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq genre_path(genre)
      end
      it '「投稿一覧」と表示される' do
        expect(page).to have_content '投稿一覧'
      end
      it 'ジャンル名が表示される' do
        expect(page).to have_content genre.name
      end
      it 'ジャンルの編集リンクが表示される' do
        expect(page).to have_link '編集する', href: edit_genre_path(genre)
      end
    end

    context 'ジャンル編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集する'
        expect(current_path).to eq edit_genre_path(genre)
      end
    end
  end

  describe '自分のジャンル編集画面のテスト' do
    before do
      visit edit_genre_path(genre)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq edit_genre_path(genre)
      end
      it '「ジャンル編集」と表示される' do
        expect(page).to have_content 'ジャンル編集'
      end
      it 'アップデートボタンが表示される' do
        expect(page).to have_button 'アップデート'
      end
      it 'name編集フォームが表示される' do
        expect(page).to have_field 'genre[name]', with: genre.name
      end
    end

    context '更新成功テスト' do
      before do
        @genre_old_name = genre.name
        fill_in 'genre[name]', with: Faker::Lorem.characters(number: 10)
        click_button 'アップデート'
      end

      it 'nameが正しく更新される' do
        expect(genre.reload.name).not_to eq @genre_old_name
      end
      it 'リダイレクト先が、保存できたジャンルの詳細画面になっている' do
        expect(current_path).to eq genre_path(genre)
      end
    end
  end

  describe 'ジャンル投稿一覧画面のテスト' do
    before do
      visit genre_genre_details_path(genre_detail.genre_id)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq genre_genre_details_path(genre_detail.genre_id)
      end
      it 'ジャンル投稿のタイトルのリンク先が正しい' do
        expect(page).to have_link genre_detail.short_title, href: genre_genre_detail_path(genre_detail.genre_id, genre_detail.id)
      end
      it 'ジャンル投稿のオピニオンが表示される' do
        expect(page).to have_content genre_detail.short_body
      end
      it 'ジャンル投稿の更新時間が表示される' do
        expect(page).to have_content genre_detail.update_time
      end
      it '新規ジャンル投稿画面へのリンクが存在する' do
        expect(page).to have_link '', href: new_genre_genre_detail_path(genre_detail.genre_id)
      end
      it '「ガイド一覧」と表示される' do
        expect(page).to have_content 'ガイド一覧'
      end
      it '「更新日時」と表示される' do
        expect(page).to have_content '更新日時'
      end
      it '「タイトル」と表示される' do
        expect(page).to have_content 'タイトル'
      end
      it '「ガイド内容」と表示される' do
        expect(page).to have_content 'ガイド内容'
      end
      it 'ガイドが紐づいているジャンル名が表示される' do
        expect(page).to have_content genre_detail.genre.name
      end
    end
  end

  describe '新規ジャンル投稿画面のテスト' do
    before do
      visit new_genre_genre_detail_path(genre_detail.genre_id)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq new_genre_genre_detail_path(genre_detail.genre_id)
      end
      it 'ガイド新規投稿' do
        expect(page).to have_content 'ガイド新規投稿'
      end
      it 'タイトル' do
        expect(page).to have_content 'タイトル'
      end
      it 'ガイド内容' do
        expect(page).to have_content 'ガイド内容'
      end
      it '投稿するボタンが表示される' do
        expect(page).to have_button '投稿する'
      end
      it 'タイトル投稿フォームが表示される' do
        expect(page).to have_field 'genre_detail[title]'
      end
      it 'ガイド内容投稿フォームが表示される' do
        expect(page).to have_field 'genre_detail[body]'
      end
    end

    context 'ジャンル投稿成功テスト' do
      before do
        fill_in 'genre_detail[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'genre_detail[body]', with: Faker::Lorem.characters(number: 20)
      end

      it '自分の新しいジャンル投稿が正しく保存される' do
        expect { click_button '投稿する' }.to change{ GenreDetail.count }.by(1)
      end
      it 'リダイレクト先が、保存できたジャンル投稿の詳細画面になっている' do
        click_button '投稿する'
        expect(current_path).to eq genre_genre_detail_path(GenreDetail.last.genre_id,GenreDetail.last.id)
      end
    end
  end

  describe 'ジャンル投稿詳細画面のテスト' do
    before do
      visit genre_genre_detail_path(genre_detail.genre_id, genre_detail.id)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq genre_genre_detail_path(genre_detail.genre_id, genre_detail.id)
      end
      it '「ガイド情報」と表示される' do
        expect(page).to have_content 'ガイド情報'
      end
      it '「ジャンル」と表示される' do
        expect(page).to have_content 'ジャンル'
      end
      it '「タイトル」と表示される' do
        expect(page).to have_content 'タイトル'
      end
      it '「ガイド内容」と表示される' do
        expect(page).to have_content 'ガイド内容'
      end
      it 'ジャンルの名前に詳細リンクがある' do
        expect(page).to have_link genre_detail.genre.name, href: genre_path(genre_detail.genre.id)
      end
      it 'タイトル(title)が表示される' do
        expect(page).to have_content genre_detail.title
      end
      it 'ガイド内容(body)が表示される' do
        expect(page).to have_content genre_detail.body
      end
      it 'ジャンル投稿の編集リンクが表示される' do
        expect(page).to have_link '編集する', href: edit_genre_genre_detail_path(genre_detail.genre_id, genre_detail.id)
      end
    end

    context 'ジャンル投稿編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集する'
        expect(current_path).to eq edit_genre_genre_detail_path(genre_detail.genre_id, genre_detail.id)
      end
    end
  end

  describe 'ジャンル投稿編集画面のテスト' do
    before do
      visit edit_genre_genre_detail_path(genre_detail.genre_id, genre_detail.id)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq edit_genre_genre_detail_path(genre_detail.genre_id, genre_detail.id)
      end
      it '「ガイド編集」と表示される' do
        expect(page).to have_content 'ガイド編集'
      end
      it '「タイトル」と表示される' do
        expect(page).to have_content 'タイトル'
      end
      it '「ガイド内容」と表示される' do
        expect(page).to have_content 'ガイド内容'
      end
      it 'アップデートボタンが表示される' do
        expect(page).to have_button 'アップデート'
      end
      it 'title編集フォームが表示される' do
        expect(page).to have_field 'genre_detail[title]', with: genre_detail.title
      end
      it 'body編集フォームが表示される' do
        expect(page).to have_field 'genre_detail[body]', with: genre_detail.body
      end
    end

    context '更新成功テスト' do
      before do
        @genre_detail_old_title = genre_detail.title
        @genre_detail_old_body = genre_detail.body
        fill_in 'genre_detail[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'genre_detail[body]', with: Faker::Lorem.characters(number: 20)
        click_button 'アップデート'
      end

      it 'titleが正しく更新される' do
        expect(genre_detail.reload.title).not_to eq @genre_detai_old_title
      end
      it 'bodyが正しく更新される' do
        expect(genre_detail.reload.body).not_to eq @genre_detail_old_body
      end
      it 'リダイレクト先が、保存できたジャンル投稿の詳細画面になっている' do
        expect(current_path).to eq genre_genre_detail_path(genre_detail.genre_id, genre_detail.id)
      end
    end
  end

  describe 'プロジェクト一覧画面のテスト' do
    before do
      visit projects_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq projects_path
      end
      it 'プロジェクトのリンク先が正しい' do
        expect(page).to have_link project.short_name, href: project_path(project)
      end
      it '始動日時が表示される' do
        expect(page).to have_content project.make_time
      end
      it '概要が表示される' do
        expect(page).to have_content project.short_introduction
      end
      it '自分と他人のプロジェクト画像が表示される：　プロジェクト画像（自分と他人）＋右下arrow画像' do
        expect(all('img').size).to eq(3)
      end
      it '新規投稿画面へのリンクが存在する' do
        expect(page).to have_link '', href: new_project_path
      end
      it '「プロジェクト一覧」と表示される' do
        expect(page).to have_content 'プロジェクト一覧'
      end
      it '「始動」と表示される' do
        expect(page).to have_content '始動'
      end
      it '「アイコン」と表示される' do
        expect(page).to have_content 'アイコン'
      end
      it '「プロジェクト名」と表示される' do
        expect(page).to have_content 'プロジェクト名'
      end
      it '「概要」と表示される' do
        expect(page).to have_content '概要'
      end
    end
  end

  describe '新規プロジェクト画面のテスト' do
    before do
      visit new_project_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq new_project_path
      end
      it '新規プロジェクト' do
        expect(page).to have_content '新規プロジェクト'
      end
      it 'プロジェクト名' do
        expect(page).to have_content 'プロジェクト名'
      end
      it '詳細' do
        expect(page).to have_content '詳細'
      end
      it 'プロジェクト画像' do
        expect(page).to have_content 'プロジェクト画像'
      end
      it '始動ボタンが表示される' do
        expect(page).to have_button '始動'
      end
      it 'nameプロジェクト名フォームが表示される' do
        expect(page).to have_field 'project[name]'
      end
      it 'introduction詳細フォームが表示される' do
        expect(page).to have_field 'project[introduction]'
      end
      it 'project_imageプロジェクト画像フォームが表示される' do
        expect(page).to have_field 'project[project_image]'
      end
    end

    context 'プロジェクト立ち上げ成功テスト' do
      before do
        fill_in 'project[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'project[introduction]', with: Faker::Lorem.characters(number: 20)
        image_path = Rails.root.join('spec/factories/images/desert.jpg')
        attach_file('project[project_image]', image_path)
      end

      it '新しいプロジェクトが正しく保存される' do
        expect { click_button '始動' }.to change{ Project.count }.by(1)
      end
      it 'リダイレクト先が、保存できたプロジェクトの詳細画面になっている' do
        click_button '始動'
        expect(current_path).to eq project_path(Project.last.id)
      end
    end
  end

  describe 'プロジェクト詳細画面のテスト' do
    before do
      visit project_path(project)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq project_path(project)
      end
      it '「プロジェクト紹介」と表示される' do
        expect(page).to have_content 'プロジェクト紹介'
      end
      it '「アイコン」と表示される' do
        expect(page).to have_content 'アイコン'
      end
      it '「プロジェクト名」と表示される' do
        expect(page).to have_content 'プロジェクト名'
      end
      it '「メンバー」と表示される' do
        expect(page).to have_content 'メンバー'
      end
      it 'プロジェクト名が表示される' do
        expect(page).to have_content project.name
      end
      it 'プロジェクト画像が表示される：プロジェクト画像＋右下arrow画像' do
        expect(all('img').size).to eq(2)
      end
      it 'プロジェクト詳細が表示される' do
        expect(page).to have_content project.introduction
      end
      it '「プロジェクト詳細」と表示される' do
        expect(page).to have_content 'プロジェクト詳細'
      end
      it 'プロジェクトの編集リンクが表示される' do
        expect(page).to have_link '編集する', href: edit_project_path(project)
      end
      it 'プロジェクトの削除リンクが表示される' do
        expect(page).to have_link '削除する', href: project_path(project)
      end
      it 'プロジェクトのディスカッションリンクが表示される' do
        expect(page).to have_link 'ディスカッション'
      end
    end

    context 'プロジェクト編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集する'
        expect(current_path).to eq edit_project_path(project)
      end
    end

    context 'プロジェクト削除リンクのテスト' do
      before do
        click_link '削除する'
      end

      it '正しく削除され、リダイレクト先が、プロジェクト一覧画面になっている' do
        expect(Project.where(id: project.id).count).to eq 0
        expect(current_path).to eq projects_path
      end
    end
  end

  describe 'プロジェクト編集画面のテスト' do
    before do
      visit edit_project_path(project)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq edit_project_path(project)
      end
      it '「プロジェクト編集」と表示される' do
        expect(page).to have_content 'プロジェクト編集'
      end
      it '「プロジェクト名」と表示される' do
        expect(page).to have_content 'プロジェクト名'
      end
      it '「詳細」と表示される' do
        expect(page).to have_content '詳細'
      end
      it '「プロジェクト画像」と表示される' do
        expect(page).to have_content 'プロジェクト画像'
      end
      it 'アップデートボタンが表示される' do
        expect(page).to have_button 'アップデート'
      end
      it 'name編集フォームが表示される' do
        expect(page).to have_field 'project[name]', with: project.name
      end
      it 'introduction編集フォームが表示される' do
        expect(page).to have_field 'project[introduction]', with: project.introduction
      end
      it 'project_imageフォームが表示される' do
        expect(page).to have_field 'project[project_image]'
      end
    end

    context '更新成功テスト' do
      before do
        @project_old_name = project.name
        @project_old_introduction = project.introduction
        fill_in 'project[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'project[introduction]', with: Faker::Lorem.characters(number: 20)
        image_path = Rails.root.join('spec/factories/images/desert.jpg')
        attach_file('project[project_image]', image_path)
        click_button 'アップデート'
      end

      it 'nameが正しく更新される' do
        expect(project.reload.name).not_to eq @project_old_name
      end
      it 'introductionが正しく更新される' do
        expect(project.reload.introduction).not_to eq @project_old_introduction
      end
      it 'リダイレクト先が、保存できたプロジェクトの詳細画面になっている' do
        expect(current_path).to eq project_path(project)
      end
    end
  end

  describe 'メンバー一覧画面のテスト' do
    before do
      visit index_users_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq index_users_path
      end
      it 'メンバーのリンク先がそれぞれ正しい' do
        expect(page).to have_link user.short_name, href: show_users_path(user)
        expect(page).to have_link other_user.short_name, href: show_users_path(other_user)
      end
      it '自己紹介が表示される' do
        expect(page).to have_content user.short_introduction
      end
      it '入会状況が表示される' do
        expect(page).to have_content '有効'
      end
      it '自分と他人のアイコン画像が表示される：　アイコン画像（自分と他人）＋右下arrow画像' do
        expect(all('img').size).to eq(3)
      end
      it '「メンバー一覧」と表示される' do
        expect(page).to have_content 'メンバー一覧'
      end
      it '「アイコン」と表示される' do
        expect(page).to have_content 'アイコン'
      end
      it '「ニックネーム」と表示される' do
        expect(page).to have_content 'ニックネーム'
      end
      it '「自己紹介」と表示される' do
        expect(page).to have_content '自己紹介'
      end
      it '「入会状況」と表示される' do
        expect(page).to have_content '入会状況'
      end
    end
  end
end

