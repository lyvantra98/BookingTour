class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  acts_as_nested_set
  delegate :name, :to => :user, :prefix => true
  validates :content, presence: true, length: {maximum: Settings.size.text_2000}
  scope :order_desc, -> {order created_at: :desc}
end
