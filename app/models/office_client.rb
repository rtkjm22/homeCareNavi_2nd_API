class OfficeClient < ApplicationRecord
  belongs_to :staff
  has_one_attached :avatar

  validates :name, presence: true, length: { maximum: 200 }
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :furigana, presence: true, length: { maximum: 200 }
  validates :postal, presence: true, length: { maximum: 8 }
  validates :address, presence: true, length: { maximum: 200 }
  validates :family, presence: true
  validates :avatar, content_type: { in: %w[image/jpg image/jpeg image/png] },
                     size: { less_than: 5.megabytes }

  def avatar_url
    avatar.attached? ? Rails.application.routes.url_helpers.url_for(avatar) : nil
  end
end
