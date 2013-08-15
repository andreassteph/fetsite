class UsersController < ApplicationController
    def index 
    @users = User.all
    end
    def add_role
    @user= User.find(params[:id])
    @user.add_role(params[:role])
    end
    def do_confirm
    @user= User.find(params[:id])
    @user.confirm!
    end
end
