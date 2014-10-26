class HomeController < ApplicationController
  def index
    @beispiele = Beispiel.last([Beispiel.count, 3].min)
    @neuigkeiten = Neuigkeit.recent

  end
  def dev

  end
  def kontakt
    t=YAML.load_file("#{::Rails.root.to_s}/config/contact_topic.yml")
    @themen = Thema.where(:id=>t)
  end
  def intern
    authorize! :seeintern, User
    @neuigkeiten = Neuigkeit.intern.recent
    @themengruppen=Themengruppe.intern.order(:priority).reverse
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
      @results = Sunspot.search Neuigkeit, Fetprofile do
        fulltext params['query']
      end
      @neuigkeiten=[];
      if can?(:showintern, Neuigkeit)
        #@neuigkeiten=Neuigkeit.search(params['query'])
      else
       # @neuigkeiten =Neuigkeit.search(params['query']).public
      end
  #    @fetprofiles = Fetprofile.search(params['query'])
      @fetprofiles=[]
      if can?(:showintern, Neuigkeit)
        @themen=Thema.search(params['query'])
      else
        @themen=Thema.search(params['query']).public
      end

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
  def choose_contact_topics
    File.open("config/contact_topic.yml",'w'){|f|  f.write(params[:themen].to_yaml)} 
    redirect_to admin_home_index_path
  end

end
