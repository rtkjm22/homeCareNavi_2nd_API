# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable, :rememberable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :confirmable

  include DeviseTokenAuth::Concerns::User
  include Discard::Model

  validates :name, presence: true, length: { maximum: 50 }
  validates :tel, presence: true
  validates :postal, presence: true, length: { is: 7 }
  validates :address, presence: true, length: { maximum: 255 }

  def client? = type == 'Client'
  def manager? = type == 'Manager'

  # レスポンスから:discarded_atを除外し、:typeを含めるようにする
  def as_json(options = {})
    if options[:except]
      options[:except] << :discarded_at
    else
      options[:except] = :discarded_at
    end

    super(options.merge(methods: :type))
  end

  # 論理削除されている場合は、devise_token_authのログイン判定でfalseを返すようにする
  # @see https://github.com/jhawthorn/discard#working-with-devise
  def active_for_authentication?
    super && !discarded?
  end
end
