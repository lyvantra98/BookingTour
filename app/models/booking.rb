class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  enum status: %i(waiting accepted deny)
  validates :number_people, presence: true, numericality: true

  delegate :name, :date_from, :date_to, :location_from, :location_to, :price, :to => :tour, :prefix => true
  delegate :name, :to => :user, :prefix => true
  scope :select_booking, -> {select :id, :status, :number_people, :user_id, :tour_id}
  scope :select_between_date, -> { where("created_at BETWEEN ? AND ?",
    Date.today.beginning_of_month, Date.today.end_of_month)}
end
