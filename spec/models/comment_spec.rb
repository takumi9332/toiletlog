require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe 'コメント投稿' do
    it "全ての値が正しく入力されていれば投稿できる" do
      expect(@comment).to be_valid
    end
    it "rateが空では投稿できない" do
      @comment.rate = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Rateを入力してください")
    end
    it "rateが文字列では投稿できない" do
      @comment.rate = 'one'
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Rateは数値で入力してください")
    end
    it "rateが6以上では投稿できない" do
      @comment.rate = 6
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Rateは5以下の値にしてください")
    end
    it "rateが1未満では投稿できない" do
      @comment.rate = 0
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Rateは1以上の値にしてください")
    end
    it "textが空では投稿できない" do
      @comment.text = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Textを入力してください")
    end
    it "textが100文字より多いと投稿できない" do
      @comment.text = 'あ' * 101
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Textは100文字以内で入力してください")
    end
    it "userが紐付いていなければ投稿できない" do
      @comment.user = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Userを入力してください")
    end
    it "toiletが紐付いていなければ投稿できない" do
      @comment.toilet = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Toiletを入力してください")
    end
  end
end
