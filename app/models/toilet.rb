class Toilet < ApplicationRecord
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :sex
  belongs_to :type
  belongs_to :washlet
  belongs_to :clean
  belongs_to :user
  has_many :comments

  with_options presence: true do
    validates :image
    validates :city
    validates :address
    validates :sex_id
    validates :type_id
    validates :washlet_id
    validates :clean_id
  end
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :info, length: { maximum: 1000 }

  ransacker :comments_count do
    query = '(SELECT COUNT(comments.toilet_id) FROM comments WHERE comments.toilet_id = toilets.id GROUP BY comments.toilet_id)'
    Arel.sql(query)
  end
end
