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
    def do_confirm
    @user= User.find(params[:id])
    @user.confirm!

    redirect_to users_url
    end
end
