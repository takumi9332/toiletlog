require 'rails_helper'

RSpec.describe 'トイレ情報の投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'トイレ情報の投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_toilet_path
      # フォームに情報を入力する
      attach_file 'toilet[image]', "#{Rails.root}/public/images/test_image.png"
      select '北海道', from: 'toilet[prefecture_id]'
      fill_in 'toilet[city]', with: '札幌市'
      fill_in 'toilet[address]', with: '札幌1-1-1'
      find('input[name="toilet[sex_id]"][value="1"]').click
      find('input[name="toilet[type_id]"][value="1"]').click
      find('input[name="toilet[washlet_id]"][value="1"]').click
      find('input[name="toilet[clean_id]"][value="1"]').click
      # 送信するとToiletモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Toilet.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿した内容のトイレ情報が存在することを確認する
      expect(page).to have_selector "img"
    end
  end
  context 'トイレ情報の投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
  end
end

RSpec.describe 'トイレ情報の編集', type: :system do
  before do
    @toilet1 = FactoryBot.create(:toilet)
    @toilet2 = FactoryBot.create(:toilet)
  end
  context 'トイレ情報の編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したトイレの編集ができる' do
      # トイレ1を投稿したユーザーでログインする
      sign_in(@toilet1.user)
      # トイレ1に「編集」ボタンがあることを確認する
      visit toilet_path(@toilet1)
      expect(
        find('a[class="toilet-edit"]')
      ).to have_content '編集'
      # 編集ページへ遷移する
      visit edit_toilet_path(@toilet1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('select[name="toilet[prefecture_id]"]').value.to_i
      ).to eq @toilet1.prefecture_id
      expect(
        find('input[name="toilet[city]"]').value
      ).to eq @toilet1.city
      expect(
        find('input[name="toilet[address]"]').value
      ).to eq @toilet1.address
      expect(
        find('input[name="toilet[sex_id]"][value="1"]').value.to_i
      ).to eq @toilet1.sex_id
      expect(
        find('input[name="toilet[type_id]"][value="1"]').value.to_i
      ).to eq @toilet1.type_id
      expect(
        find('input[name="toilet[washlet_id]"][value="1"]').value.to_i
      ).to eq @toilet1.washlet_id
      expect(
        find('input[name="toilet[clean_id]"][value="1"]').value.to_i
      ).to eq @toilet1.clean_id
      # 投稿内容を編集する
      attach_file 'toilet[image]', "#{Rails.root}/public/images/test_image2.png"
      select '千葉県', from: 'toilet[prefecture_id]'
      fill_in 'toilet[city]', with: '千葉市'
      fill_in 'toilet[address]', with: '千葉1-1-1'
      find('input[name="toilet[sex_id]"][value="2"]').click
      find('input[name="toilet[type_id]"][value="2"]').click
      find('input[name="toilet[washlet_id]"][value="2"]').click
      find('input[name="toilet[clean_id]"][value="2"]').click
      # 編集してもToiletモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Toilet.count }.by(0)
      # 詳細ページに遷移したことを確認する
      expect(current_path).to eq toilet_path(@toilet1)
      # 詳細ページには先ほど変更した内容のトイレ情報が存在することを確認する
      expect(page).to have_selector "img[src$='test_image2.png']"
      expect(page).to have_content '千葉県'
      expect(page).to have_content '千葉市'
      expect(page).to have_content '千葉1-1-1'
      expect(page).to have_content '女子トイレ'
      expect(page).to have_content '和式トイレ'
      expect(page).to have_content 'ウォシュレットなし'
      expect(page).to have_content 'やや綺麗'
    end
  end
  context 'トイレ情報の編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したトイレ情報の編集画面には遷移できない' do
      # トイレ1を投稿したユーザーでログインする
      sign_in(@toilet1.user)
      # トイレ2に「編集」ボタンがないことを確認する
      visit toilet_path(@toilet2)
      expect(page).to have_no_content '編集'
    end
    it 'ログインしていないとトイレ情報の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # トイレ1に「編集」ボタンがないことを確認する
      visit toilet_path(@toilet1)
      expect(page).to have_no_content '編集'
      # トイレ2に「編集」ボタンがないことを確認する
      visit toilet_path(@toilet2)
      expect(page).to have_no_content '編集'
    end
  end
end

RSpec.describe 'トイレ情報の削除', type: :system do
  before do
    @toilet1 = FactoryBot.create(:toilet)
    @toilet2 = FactoryBot.create(:toilet)
  end
  context 'トイレ情報の削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したトイレ情報の削除ができる' do
      # トイレ情報1を投稿したユーザーでログインする
      sign_in(@toilet1.user)
      # トイレ情報1に「削除」ボタンがあることを確認する
      visit toilet_path(@toilet1)
      expect(
        find('a[class="toilet-destroy"]')
      ).to have_content '削除'
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find('a[class="toilet-destroy"]').click
      }.to change { Toilet.count }.by(-1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq root_path
      # トップページにはトイレ情報1の内容が存在しないことを確認する
      expect(page).to have_no_selector "img[src$='test_image1.png']"
    end
  end
  context 'トイレ情報の削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したトイレ情報の削除ができない' do
      # トイレ情報1を投稿したユーザーでログインする
      sign_in(@toilet1.user)
      # トイレ情報2に「削除」ボタンが無いことを確認する
      visit toilet_path(@toilet2)
      expect(page).to have_no_content '削除'
    end
    it 'ログインしていないとトイレ情報の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # トイレ情報1に「削除」ボタンが無いことを確認する
      visit toilet_path(@toilet1)
      expect(page).to have_no_content '削除'
      # トイレ情報2に「削除」ボタンが無いことを確認する
      visit toilet_path(@toilet2)
      expect(page).to have_no_content '削除'
    end
  end
end