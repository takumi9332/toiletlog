class Type < ActiveHash::Base
  self.data = [
    { id: 1, name: '洋式トイレ' },
    { id: 2, name: '和式トイレ' },
    { id: 3, name: '両方ある' }
  ]
  include ActiveHash::Associations
  has_many :toilets
end
