class ConfigController < ApplicationController
  def index
    
  end
  def get_git_update
    g = Git.open(".")

    flash[:notice] ="Test"
#    flash[:notice] =g.remote("github").fetch
   redirect_to config_url

  end
end