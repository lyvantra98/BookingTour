class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: Settings.size.length_max_name}
  validates :email, presence: true, length: {maximum: Settings.size.length_max_255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.size.min_password}, allow_nil: true
  validates :phone, presence: true
  validates :address, presence: true, length: {maximum: Settings.size.length_max_255}

  scope :show_user, -> {select :id, :name, :email, :phone, :address, :is_admin}
  scope :show_user_desc, -> {order created_at: :desc}
  scope :select_admin, -> {where is_admin: :true}
  scope :search_user, ->(search){
    search.squish! if search
    ransack(name_cont: search).result
  }
end
