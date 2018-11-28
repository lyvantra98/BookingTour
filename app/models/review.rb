class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  delegate :name, to: :user, :prefix => true

  delegate :id, :name, to: :tour, prefix: true
  validates :title, presence: true, length: {maximum: Settings.size.length_max_255}
  validates :content, presence: true, length: {maximum: Settings.size.text_2000}
  scope :show_review, -> {select :id, :title, :content, :user_id}
end
