require 'rails_helper'

RSpec.describe Toilet, type: :model do
  before do
    @toilet = FactoryBot.build(:toilet)
  end

  describe 'トイレ情報投稿' do
    it "全ての値が正しく入力されていれば投稿できる" do
      expect(@toilet).to be_valid
    end
    it "imageが空では投稿できない" do
      @toilet.image = nil
      @toilet.valid?
      expect(@toilet.errors.full_messages).to include("トイレ画像を入力してください")
    end
    it "prefectureが1では投稿できない" do
      @toilet.prefecture_id = 1
      @toilet.valid?
      expect(@toilet.errors.full_messages).to include("都道府県は1以外の値にしてください")
    end
    it "cityが空では投稿できない" do
      @toilet.city = ''
      @toilet.valid?
      expect(@toilet.errors.full_messages).to include("市区町村を入力してください")
    end
    it "addressが空では投稿できない" do
      @toilet.address = ''
      @toilet.valid?
      expect(@toilet.errors.full_messages).to include("番地を入力してください")
    end
    it "buildingは空でも投稿できる" do
      @toilet.building = ''
      expect(@toilet).to be_valid
    end
    it "sexが空では投稿できない" do
      @toilet.sex_id = ''
      @toilet.valid?
      expect(@toilet.errors.full_messages).to include("何トイレかを入力してください")
    end
    it "typeが空では投稿できない" do
      @toilet.type_id = ''
      @toilet.valid?
      expect(@toilet.errors.full_messages).to include("種類を入力してください")
    end
    it "washletが空では投稿できない" do
      @toilet.washlet_id = ''
      @toilet.valid?
      expect(@toilet.errors.full_messages).to include("ウォシュレットを入力してください")
    end
    it "cleanが空では投稿できない" do
      @toilet.clean_id = ''
      @toilet.valid?
      expect(@toilet.errors.full_messages).to include("状態を入力してください")
    end
    it "infoは空でも投稿できる" do
      @toilet.info = ''
      expect(@toilet).to be_valid
    end
    it "infoが1000文字より多いと投稿できない" do
      @toilet.info = 'あ' * 1001
      @toilet.valid?
      expect(@toilet.errors.full_messages).to include("情報は1000文字以内で入力してください")
    end
    it "userが紐付いていなければ投稿できない" do
      @toilet.user = nil
      @toilet.valid?
      expect(@toilet.errors.full_messages).to include("Userを入力してください")
    end
  end
end
