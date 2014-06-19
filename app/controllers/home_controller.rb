class HomeController < ApplicationController
  def index
    @beispiele = Beispiel.last([Beispiel.count, 3].min)
    @neuigkeiten = Neuigkeit.recent

  end
  def dev

  end
  def kontakt
  end
  def intern
    authorize! :seeintern, User
    @neuigkeiten = Neuigkeit.intern.recent
    @themengruppen=Themengruppe.intern
  end
  def admin
    authorize! :doadmin, User
    

  end

  def startdev
  render 'setup_fetsite_dev'
  end
  def linksnotimplemented
  render 'links_notimplemented'
  end
  def search
    unless params['query'].nil? || params['query'].empty?
      @neuigkeiten=Neuigkeit.search(params['query'])
      @fetprofiles = Fetprofile.search(params['query'])
      @themen=Thema.search(params['query'])
    else
      @neuigkeiten=[]
      @fetprofiles=[]
      @themen=[]
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
end
