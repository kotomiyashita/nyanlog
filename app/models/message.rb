class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many_attached :images
  validates :content, presence: true, unless: :was_attached?

  def was_attached?
    self.images.attached?
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  validates :category_id, numericality: { other_than: 1 }
end
