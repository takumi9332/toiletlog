require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it "全ての値が正しく入力されていれば登録できる" do
      expect(@user).to be_valid
    end
    it "nameが空では登録できない" do
      @user.name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください")
    end
    it "nameが9文字以上では登録できない" do
      @user.name = 'aiueoaiue'
      @user.valid?
      expect(@user.errors.full_messages).to include("名前は8文字以内で入力してください")
    end
    it "emailが空では登録できない" do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
    end
    it "同じemailがある場合登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
    end
    it "emailに@がないと登録できない" do
      @user.email = 'aaabbb'
      @user.valid?
      expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
    end
    it "passwordが空では登録できない" do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end
    it "passwordが5文字以下では登録できない" do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
    end
    it "passwordが存在してもpassword_confirmationが空では登録できない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it "passwordとpassword_confirmationが同じでないと登録できない" do
      @user.password = "123456"
      @user.password_confirmation = "654321"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
  end
end
