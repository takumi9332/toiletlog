class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :toilet

  validates :rate, presence: true, numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 1}
  validates :text, presence: true, length: { maximum: 100 }
end
