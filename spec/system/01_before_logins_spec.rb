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
      it 'Sign inリンクが表示される：青色リンク表示が「こちら」である' do
        expect(page).to have_link 'こちら', href: '/sign_in'
      end
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
    end
  end
  
end
