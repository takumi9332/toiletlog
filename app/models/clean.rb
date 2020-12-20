class Clean < ActiveHash::Base
  self.data = [
    { id: 1, name: 'すごく綺麗' },
    { id: 2, name: 'やや綺麗' },
    { id: 3, name: 'やや汚い' },
    { id: 4, name: 'すごく汚い' }
  ]
  include ActiveHash::Associations
  has_many :toilets
end
