require 'rails_helper'

RSpec.describe '評価とコメント投稿', type: :system do
  before do
    @toilet = FactoryBot.create(:toilet)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーはトイレ情報の詳細ページで評価とコメント投稿できる' do
    # ログインする
    sign_in(@toilet.user)
    # トイレ情報の詳細ページに遷移する
    visit toilet_path(@toilet)
    # フォームに情報を入力する
    fill_in 'comment_text', with: @comment
    find('img[alt="5"]').click
    # 評価とコメントを送信すると、Commentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq toilet_path(@toilet)
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
  it 'ログインしていないとトイレ情報の詳細ページに評価とコメント投稿フォームがない' do
    # トップページに移動する
    visit root_path
    # トイレ情報の詳細ページに遷移する
    visit toilet_path(@toilet)
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector 'comment_text'
    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content 'コメントの投稿には新規登録/ログインが必要です'
  end
end