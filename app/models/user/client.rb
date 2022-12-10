class Client < User
  has_many :reserves, dependent: :destroy
end
