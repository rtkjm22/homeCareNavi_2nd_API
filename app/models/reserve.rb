class Reserve < ApplicationRecord
  belongs_to :office
  belongs_to :client
end
