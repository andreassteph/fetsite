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
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers => [:facebook,:ldap]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name
  # attr_accessible :title, :body
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
logger.debug auth.to_s
    logger.debug "DDD Username= #{auth.username}"
   # user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.uid,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                         )
    end

    user
  end
 def self.find_for_ldap_oauth(auth,signed_in_resource=nil)
  # debug "sdfg"

   user= User.where(:provider=>auth.provider,:uid=>auth.extra.raw_info.uid).first
   unless user
     user= User.create(name:auth.extra.raw_info.uid.first,
                       provider:auth.provider,
                       uid:auth.extra.raw_info.uid.first,
                       email:auth.extra.raw_info.mail.first.to_s,
                       password:Devise.friendly_token[0,20])
    user.add_role("fetuser")
logger.debug(auth.extra.raw_info.to_s)
   end
   unless user
    # user=User.create(name:"fail",
    #                  provider:"ldap",
    #                  uid:"sdf",
    #                  email:"sdf@fet.at",
    #                  password:Devise.friendly_token[0,20])
   
   end
   user
 end

 def self.new_with_session(params, session)
   super.tap do |user|
     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
       user.email = data["email"] if user.email.blank?
     end
    end
  end
  
end
