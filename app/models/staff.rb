class Staff < ApplicationRecord
  enum :role, { worker: 0, care_manager: 1 }
  belongs_to :office
end
