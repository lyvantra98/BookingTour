class Tour < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :category
  enum status: %i(close open)

  validates :name, presence: true, length: {maximum: Settings.size.length_max_255}
  validates :date_from, presence: true
  validates :date_to, presence: true
  validates :location_from, presence: true, length: {maximum: Settings.size.length_max_255}
  validates :location_to, presence: true, length: {maximum: Settings.size.length_max_255}
  validates :price, presence: true
  validates :max_people, presence: true, numericality: true
  validates :min_people, presence: true, numericality: true
  validates :description, presence: true, length: {maximum: Settings.size.text_2000}

  scope :select_custom, -> {select :id, :status, :name, :date_from, :date_to, :location_from,
    :location_to, :price, :max_people, :min_people, :description}
  scope :is_open, -> {where status: :open}
  scope :show_tour_desc, -> {order created_at: :desc}
end
