class Staff < ApplicationRecord
  enum role: { worker: 0, care_manager: 1 }, _prefix: true
  belongs_to :office
  has_many :office_clients, dependent: :restrict_with_error
  has_one_attached :avatar

  validates :name, presence: true
  validates :furigana, presence: true
  validates :avatar, content_type: { in: %w[image/jpg image/jpeg image/png] },
                     size: { less_than: 5.megabytes }

  def avatar_url
    avatar.attached? ? Rails.application.routes.url_helpers.url_for(avatar) : nil
  end
end
