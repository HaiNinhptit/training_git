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

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:orders) }
    it { should have_one(:cart) }
  end

  VALID_EMAIL = [
    'email@domain.com',
    'firstname.lastname@domain.com',
    'email@subdomain.domain.com',
    'firstname+lastname@domain.com',
    '1234567890@domain.com',
    'email@domain-one.com',
    'email@domain.name',
    'email@domain.co.jp'
  ].freeze

  INVALID_EMAIL = [
    'sahara @yahoo.jp',
    'plainaddress',
    '@domain.com',
    'Joe Smith <email@domain.com>',
    'email.domain.com',
    'email@domain@domain.com',
    'email@domain',
    'email@111.222.333.44444'
  ].freeze

  describe 'valid email' do
    VALID_EMAIL.each do |email|
      it { is_expected.to allow_value(email).for(:email) }
    end
  end

  describe 'invalid email' do
    INVALID_EMAIL.each do |email|
      it { is_expected.to_not allow_value(email).for(:email) }
    end
  end
end
