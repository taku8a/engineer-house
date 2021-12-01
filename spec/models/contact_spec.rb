require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'バリデーションのテスト' do
    subject { contact.valid? }
    
    let(:contact) { build(:contact) }
    
    context 'nameカラム' do
      it '空欄でない' do
        contact.name = ''
        is_expected.to eq false
      end
    end
    
    context 'emailカラム' do
      it '空欄でない' do
        contact.email = ''
        is_expected.to eq false
      end
    end
    
    context 'contentカラム' do
      it '空欄でない' do
        contact.content = ''
        is_expected.to eq false
      end
    end
  end
end
