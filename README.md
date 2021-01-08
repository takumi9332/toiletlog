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