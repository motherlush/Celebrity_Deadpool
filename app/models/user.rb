class User < ApplicationRecord
  devise :omniauthable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.token = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.image = auth.info.image

      user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        %w[email name image].each do |attr|
          user.send("#{attr}=", data[attr]) if user.send(attr).blank?
        end
        # user.email = data["email"] if user.email.blank?
      end
    end
  end
end
