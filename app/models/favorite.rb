class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :toilet

  validates_uniqueness_of :toilet_id, scope: :user_id
end
