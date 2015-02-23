class UsersController < ApplicationController
  def index 
    @users = User.all
  end
  def add_role
    @user= User.find(params[:id])
    if (params[:role]=="fetuser" && can?(:addfetuser,User))
      @user.add_role(params[:role])
    end
    if (params[:role]=="fetadmin" && can?(:addfetadmin,User))
      @user.add_role(params[:role])
    end
    redirect_to users_url
  end
  def fb_set_default_publish_page
    if Fetsite::Application.config.facebookconfig_enabled
      if params["page"].nil? || !(current_user.provider=="facebook")
        redirect_to intern_home_index_path
      else
        @fbu=FbGraph::User.new(current_user.uid.to_s).fetch(:access_token=>session["fbuser_access_token"])
        File.open("config/page.yml",'w'){|f|  f.write(@fbu.accounts(:access_token=>session["fbuser_access_token"]).select { |p| p.name == params["page"] }.first.to_yaml)}
        logger.info @fbu.to_s
        logger.info "FbGraph Access" + session["fbuser_access_token"]
        redirect_to admin_home_index_path
      end
    end
  end
  
  def all_update
    params[:users].each do |id,u| 
      user=User.find(id) 
      user.fetprofile = Fetprofile.find(u[:fetprofile_id].to_i) if u[:fetprofile_id].to_i>0 
      user.save if can? :edit, User
    end
    redirect_to users_url
  end

  def do_confirm
    @user= User.find(params[:id])
    @user.confirm!
    redirect_to users_url
  end
end
