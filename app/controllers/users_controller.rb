class UsersController < ApplicationController
    def index 
    @users = User.all
    end
    def add_role
    @user.find(params[:id])
    @user.add_role(params[:role])
    end
end
