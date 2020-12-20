class Sex < ActiveHash::Base
  self.data = [
    { id: 1, name: '男子トイレ' },
    { id: 2, name: '女子トイレ' },
    { id: 3, name: '共用トイレ' }
  ]
  include ActiveHash::Associations
  has_many :toilets
end
