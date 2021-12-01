require 'rails_helper'

RSpec.describe "[STEP1] ユーザーログイン前のテスト", type: :system do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
    end
  end

  describe '紹介画面のテスト' do
    before do
      visit about_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end

  describe '新規登録画面のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/sign_up'
      end
      it 'Log inリンクの内容が正しい' do
        expect(page).to have_link 'こちら', href: '/sign_in'
      end
    #   it 'Log inリンクが表示される：緑色ボタンの表示が「新規登録」である' do
    #     log_in_link = find_all('a')[3].native.inner_text
    #     expect(log_in_link).to match(/新規登録/)
    #   end
    #   it 'Log inリンクの内容が正しい' do
    #     log_in_link = find_all('a')[3].native.inner_text
    #     expect(page).to have_link log_in_link, href:
    end
  end

  describe 'ログイン画面のテスト' do
    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/sign_in'
      end
      it 'Sign upリンクが表示される：青色リンク表示が「こちら」である' do
        expect(page).to have_link 'こちら', href: '/sign_up'
      end
    end
  end

  describe 'ヘッダーのテスト：ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'ホームリンクが表示されて、内容が正しい' do
        expect(page).to have_link 'ホーム', href: root_path
      end
      it 'ENGINEER HOUSEリンクが表示されて、内容が正しい' do
        expect(page).to have_link 'ENGINEER HOUSE', href: root_path
      end
      it '紹介リンクが表示されて、内容が正しい' do
        expect(page).to have_link '紹介', href: about_path
      end
      it '新規登録リンクが表示されて、内容が正しい' do
        expect(page).to have_link '新規登録', href: new_user_registration_path
      end
      it 'ログインリンクが表示されて、内容が正しい' do
        expect(page).to have_link 'ログイン', href: new_user_session_path
      end
      it 'お問い合わせリンクが表示されて、内容が正しい' do
        expect(page).to have_link 'お問い合わせ', href: new_contact_path
      end
    end
  end

  describe 'ユーザー新規登録テスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規登録'
      end
      it '「ニックネーム」と表示される' do
        expect(page).to have_content 'ニックネーム'
      end
      it '「自己紹介」と表示される' do
        expect(page).to have_content '自己紹介'
      end
      it '「プロフィール画像」と表示される' do
        expect(page).to have_content 'プロフィール画像'
      end
      it '「メールアドレス」と表示される' do
        expect(page).to have_content 'メールアドレス'
      end
      it '「パスワード(６文字以上)」と表示される' do
        expect(page).to have_content 'パスワード(６文字以上)'
      end
      it '「パスワード(確認用)」と表示される' do
        expect(page).to have_content 'パスワード(確認用)'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'introductionフォームが表示される' do
        expect(page).to have_field 'user[introduction]'
      end
      it 'profile_imageフォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録成功テスト' do
      before do
        fill_in 'user[name]',with: Faker::Name.name
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 20)
        image_path = Rails.root.join('spec/factories/images/desert.jpg')
        attach_file('user[profile_image]', image_path)
        fill_in 'user[email]', with: Faker::Internet.email
        password = Faker::Internet.password(min_length: 6)
        fill_in 'user[password]', with: password
        fill_in 'user[password_confirmation]', with: password
      end

      it '正しく新規登録される' do
        expect { click_button "新規登録" }.to change{ User.count }.by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザーのマイページになっている' do
        click_button '新規登録'
        expect(current_path).to eq(mypage_users_path)
      end
    end

    context '新規登録失敗テスト' do
      
      # before doで定義する必要はない。何も入力しない。バリデーションエラーpresence: trueで
      # 空文字を許さないので、render: newする
      
      it '新規登録に失敗し、新規登録画面にリダイレクトされる' do
        click_button '新規登録'
        expect(current_path).to eq user_registration_path
      end
    end
  end

  describe 'ユーザーログインテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it '「メールアドレス」と表示される' do
        expect(page).to have_content 'メールアドレス'
      end
      it '「パスワード(６文字以上)」と表示される' do
        expect(page).to have_content 'パスワード(６文字以上)'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、ログインしたユーザーのマイページになっている' do
        expect(current_path).to eq '/mypage'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq user_session_path
      end
    end
  end
  describe 'お問い合わせ画面のテスト' do
    before do
      visit new_contact_path
    end

    context '表示内容の確認' do
      it '「お問い合わせフォーム」と表示される' do
        expect(page).to have_content 'お問い合わせフォーム'
      end
      it '「タイトル」と表示される' do
        expect(page).to have_content 'タイトル'
      end
      it '「内容」と表示される' do
        expect(page).to have_content '内容'
      end
      it 'メールアドレス' do
        expect(page).to have_content 'メールアドレス'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'contact[email]'
      end
      it 'タイトルフォームが表示される' do
        expect(page).to have_field 'contact[name]'
      end
      it '内容フォームが表示される' do
        expect(page).to have_field 'contact[content]'
      end
      it '確認画面へ進むボタンが表示される' do
        expect(page).to have_button '確認画面へ進む'
      end
    end
  end
end
