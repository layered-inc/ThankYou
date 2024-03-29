# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string           indexed
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  image                  :string
#  name                   :string
#  team                   :string
#  team_id                :string
#  admin_flg              :boolean
#  archived               :boolean          default(FALSE), indexed
#
# Indexes
#
#  index_users_on_archived              (archived)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:slack]

  has_many :messages, class_name: "Message", foreign_key: :sender_id, inverse_of: :sender, dependent: :delete_all
  has_many :messages, class_name: "Message", foreign_key: :recipient_id, inverse_of: :recipient, dependent: :delete_all

  validates :email, presence: true

  #self.primary_key = :email

  def self.from_omniauth(auth)
    user = User.find_or_initialize_by(uid: auth.uid)
    user.provider = auth.provider
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20] if user.encrypted_password.blank?
    user.name = auth.info.name # assuming the user model has a name
    user.image = auth.info.image # assuming the user model has an image
    user.team = auth.info.team_name
    user.team_id = auth.info.team_id
    user.save

    user
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
