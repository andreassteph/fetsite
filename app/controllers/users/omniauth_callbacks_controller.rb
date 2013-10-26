
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
skip_before_filter :verify_authenticity_token
def failure
  
 # flash[:notice] = "Failure #{Hash.new(request.env)} #{Hash.new(params)}"
#redirect_to new_user_registration_url , :notice=>"Omniauth Login failed" 
super
end  
def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def ldap
logger.debug current_user.to_s
    @user=User.find_for_ldap_oauth(request.env["omniauth.auth"],current_user) 
 #  @user=User.find_for_ldap_oauth(session["devise.ldap_data"],current_user)
   # @user=User.first
#    flash[:notice]="#{request.env}"
    #  sign_in_and_redirect @user, :event=>:authentication
# debug @user
#debug 
 #   logger.info "Request  attributes hash: #{request.env}"
    if @user
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice,:success,:kind=>"Ldap") if is_navigational_format?
    else
      session["devise.ldap_data"]=request.env["omniauth.auth"]
      # set_flash_message(:notice, "sdfsdf")
      flash[:notice]=flash[:notice] + "Still not logged in "
     redirect_to new_user_registration_url
    end
  end
end
