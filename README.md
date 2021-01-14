# Toiletlog

## 概要
トイレの口コミサイト

### URL
http://13.114.135.71/
BASIC認証あり

テストアカウント
メールアドレス a@a
パスワード aaa111

### 機能一覧
ユーザー認証なしで使用できる機能
- トップページの投稿一覧(画像と星評価の平均を表示)
- トイレ情報詳細ページ
- 並び替え(入力後すぐに切り替え)
- 検索(詳細情報や住所などの複数検索)
- ページネーション(トップページは6投稿、コメント評価は8投稿まで表示)
- Ajax(コメント評価の一覧)

ユーザー認証後に使用できる機能
- トイレ情報投稿(投稿者のみ編集、削除)
- トイレ情報投稿ページにて画像アップロード＆画像プレビュー
- トイレ情報に対してのコメントと星で評価(投稿者のみ削除)
- トイレ情報のブックマーク(自分以外の投稿者のみ、もう一度押すと外れる)
- マイページにて投稿一覧、ブックマーク一覧
- ページネーション(マイページ内の投稿一覧、ブックマーク一覧、共に4投稿まで表示)
- Ajax(マイページ内の投稿一覧、ブックマーク一覧)
- エラーメッセージ日本語化(ユーザー登録、ログイン、投稿、編集)

テストの実施(RSpec、factory_bot)
- 各モデルの単体テストコード
- 各モデルの結合テストコード

### 使用している技術一覧
- Ruby
- Ruby on Rails
- HTML,CSS,JavaScript
- EC2
- S3
- MariaDB
- Unicorn
- Nginx
- Capistrano

### 制作背景
トイレを外で利用する際に「出来れば綺麗なトイレを利用したいな」という思いから開発を行った。
その他にも「ここはウォシュレットがついているのか？」、「洋式トイレはあるのか？」などの細かい情報によって、近場に選択肢があった場合により綺麗なトイレに向かうことが出来ると良いと思った。

### 今後実装したい機能
場所をわかりやすくするためにGoogle Maps APIを利用し地図を表示

# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| name               | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |

### Association
- has_many :toilets
- has_many :comments
- has_many :favorites


## toilets テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building      | string     |                                |
| sex_id        | integer    | null: false                    |
| type_id       | integer    | null: false                    |
| washlet_id    | integer    | null: false                    |
| clean_id      | integer    | null: false                    |
| info          | text       |                                |
| user          | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :comments
- has_many :favorites


## comments テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| rate        | float      | null: false, default: 0        |
| text        | text       | null: false                    |
| user        | references | null: false, foreign_key: true |
| toilet      | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :toilet


## favorites テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| toilet      | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :toilet