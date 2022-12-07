class Reserve < ApplicationRecord
  belongs_to :office
  belongs_to :client

  validates :interview_begin_at, presence: true
  validates :interview_end_at, presence: true
  validates :user_name, presence: true
  validates :user_age, presence: true
  validates :contact_tel, presence: true
  validates :is_contacted, inclusion: [true, false]

end
