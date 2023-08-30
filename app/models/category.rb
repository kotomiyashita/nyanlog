class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'ごはん' },
    { id: 3, name: 'トイレ' },
    { id: 4, name: '体重' },
    { id: 5, name: '写真' },
    { id: 6, name: 'その他' },
  ]

  include ActiveHash::Associations
  has_many :messages

  end