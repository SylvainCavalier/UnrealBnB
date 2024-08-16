class Offer < ApplicationRecord
  include PgSearch::Model
  # cloudinary


  # REVIEW : Validate file type
  has_one_attached :image

  # associations
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :description, presence: true
  validates :user_id, presence: true

  # REVIEW : SECURITY! Validate max length of text (risk of db spamming/flooding/overflow)
  # REVIEW : Validate price : not negative

  # geocoding
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # pg_search
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description ],
    associated_against: {
      user: [:username]
    },
    using: {
      tsearch: { prefix: true }
  }
end
