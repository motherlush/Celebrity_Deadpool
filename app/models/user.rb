class User < ApplicationRecord
  alias_attribute :password, :token

  devise :omniauthable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         omniauth_providers: %i[facebook]

  def has_avatar?
    self.image_url.present?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.token = Devise.friendly_token[0,20]
      user.name = auth.info.name
      # user.image_url = auth.info.profile_pic
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.name = data["name"] if user.name.blank?
        # user.image_url = data["profile_pic"] if user.image.blank?
      end
    end
  end
end
