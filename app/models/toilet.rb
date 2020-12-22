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
    validates :city
    validates :address
    validates :sex_id
    validates :type_id
    validates :washlet_id
    validates :clean_id
  end
  validates :prefecture_id, numericality: { other_than: 1 }

  def self.search(search)
    if search != ""
      Toilet.where('city LIKE ? OR address LIKE ? OR building LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      Toilet.all
    end
  end
end
