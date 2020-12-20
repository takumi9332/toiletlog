class Washlet < ActiveHash::Base
  self.data = [
    { id: 1, name: 'ウォシュレットあり' },
    { id: 2, name: 'ウォシュレットなし' },
    { id: 3, name: '両方ある' }
  ]
  include ActiveHash::Associations
  has_many :toilets
end
