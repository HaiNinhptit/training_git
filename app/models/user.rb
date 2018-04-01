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
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  validates :avatar, allow_blank: true, format: { with: /.(gif|jpg|png)\Z/i, message: 'must be a URL for GIF, JPG or PNG image.' }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
  validates :password, presence: true, length: { minimum: 6 }, on: %i(create save)
  mount_uploader :avatar, AvatarUploader
  has_one :cart
  has_many :orders
  has_many :products

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] &&
                session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  def get_users_bought_your_product
    products = self.products
    array_user_bought = []
    products.each do |product|
      orders = product.orders
      orders.each do |order|
        check = 0
        if array_user_bought.any?
          array_user_bought.each do |user|
            check = 1 if user['user_id'] == order.user_id
          end
        end
        array_user_bought.push('user_id' => order.user_id, 'name' => order.user.name.presence || 'Khong co ten') if check.zero?
      end
    end
    array_user_bought
  end

  def get_salesman
    array_user = []
    orders = self.orders
    orders.each do |order|
      order.products.each do |product|
        check = 0
        if array_user.any?
          array_user.each do |user|
            check = 1 if user['id'] == product.user_id
          end
        end
        array_user.push('id' => product.user_id) if check.zero?
      end
    end
    array_user
  end
end
