class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  validates :content, presence: true
  validates :category_id, numericality: { other_than: 1 }
end
