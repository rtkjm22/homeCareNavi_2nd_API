class Staff < ApplicationRecord
  enum role: { worker: 0, care_manager: 1 }, _prefix: true
  belongs_to :office
  has_many :office_clients, dependent: :restrict_with_error

  validates :name, presence: true
  validates :furigana, presence: true
end
