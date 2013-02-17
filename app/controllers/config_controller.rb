class ConfigController < ApplicationController
  def index
    
  end
  def get_git_update
    g = Git.open(".")
    flash[:notice] =g.remote("github").fetch
    redirect_to url_for(:action => 'index', :controller => 'config')
  end
end