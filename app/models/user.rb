# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_one :cart

  has_many :orders
  has_many :order_products, through: :orders
  has_many :products
  has_many :purchase_products, through: :order_products, source: :product
  has_many :seller_of_purchase_products, -> { distinct }, through: :purchase_products, source: :user
  has_many :orders_products_contains_your_products, through: :products, source: :order_products
  has_many :orders_contains_your_products, through: :orders_products_contains_your_products, source: :order
  has_many :users_buy_your_products, -> { distinct }, through: :orders_contains_your_products, source: :user

  validates :avatar, allow_blank: true, format: { with: /.(gif|jpg|png)\Z/i, message: 'must be a URL for GIF, JPG or PNG image.' }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
  validates :password, presence: true, length: { minimum: 6 }, on: %i[create save]

  mount_uploader :avatar, AvatarUploader

  scope :who_buy_your_products, ->(user) { where(id: user.orders_contains_your_products.map(&:user_id)) }
  scope :bought_products_for, ->(user) { where(id: user.purchase_products.map(&:user_id)) }

  #---------sign_in google, facebook-----------------------------------
  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session['devise.facebook_data'] &&
  #               session['devise.facebook_data']['extra']['raw_info']
  #       user.email = data['email'] if user.email.blank?
  #     end
  #   end
  # end

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #     user.name = auth.info.name
  #   end
  # end
end
