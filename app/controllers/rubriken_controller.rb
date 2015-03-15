class RubrikenController < ApplicationController
  before_filter {@toolbar_elements=[]}
   load_and_authorize_resource
  def index
  #  if can?(:showintern, Rubrik)
  #    @rubriken = Rubrik.all
  #    @neuigkeiten = Neuigkeit.page(params[:page]).per(3)
  #  else
  #    @rubriken = Rubrik.where(:public=>true)
  #    @neuigkeiten = Neuigkeit.public.published.page(params[:page]).per(3)
  #  end   
    
    params[:month]= Date.today.month if params[:month].nil?
    params[:year]= Date.today.year if params[:year].nil?
        
    @rubriken= Rubrik.accessible_by(current_ability, :show)
    @neuigkeiten = Neuigkeit.accessible_by(current_ability, :list).page(params[:page]).per(3)
    
    @calentries= (@rubriken.map {|r| r.calendar}).collect(&:calentries).flatten.select {|c| c.object !=nil}
    respond_to do |format|
      format.html
      format.js {render action: :show}
    end

  end
  def intern

  end
  def show
    @rubriken= Rubrik.accessible_by(current_ability, :show)
    @rubrik = Rubrik.find(params[:id])
    @moderatoren=User.with_role(:newsmoderator,@rubrik)

    params[:month]= Date.today.month if params[:month].nil?
    params[:year]= Date.today.year if params[:year].nil?
        
    @calentries= @rubrik.calendar.calentries.select {|c| c.object !=nil}
    @neuigkeiten = @rubrik.neuigkeiten.accessible_by(current_ability, :list).page(params[:page]).per(3)

    @toolbar_elements << {:text=>I18n.t('neuigkeit.new.title'), :path=> new_rubrik_neuigkeit_path(@rubrik),:hicon=>'icon-plus-sign'} if can? :verwalten, @rubrik
    @toolbar_elements << {:text=>I18n.t('common.verwalten'), :path=>verwalten_rubrik_path(@rubrik),:icon=>:pencil} if can? :verwalten, @rubrik
      
    respond_to do |format|
      format.html
      format.js
    end

  end
  
  def new
    @rubrik = Rubrik.new
  end

  def edit
    @rubrik = Rubrik.find(params[:id])
  end
  
  def create
    @rubrik = Rubrik.new(params[:rubrik])

    respond_to do |format|
      if @rubrik.save
        format.html { redirect_to @rubrik, notice: 'Rubrik was successfully created.' }      
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def addmoderator
    @rubrik = Rubrik.find(params[:id])
    if can? :addmoderator, @rubrik
      if params[:moderator].nil?
        current_user.add_role(:newsmoderator,@rubrik)
      else
        User.find(params[:moderator]).add_role(:newsmoderator, @rubrik)
      end
      
      response_notice= I18n.t("rubrik/moderatoradded")
    else
      response_notice= I18n.t("rubrik/moderatoraddnorights")
    end
    respond_to do |format|
      format.html { redirect_to @rubrik,:notice => response_notice }
    end
  end

  def removemoderator
    rubrik = Rubrik.find(params[:id])
    m = User.find(params[:moderator])
    if m.has_role?(:newsmoderator,rubrik) 
      m.remove_role(:newsmoderator,rubrik)
    end
    redirect_to verwalten_rubrik_path(rubrik)
  end

  def update
    @rubrik = Rubrik.find(params[:id])

    respond_to do |format|
      if @rubrik.update_attributes(params[:rubrik])
        format.html { redirect_to @rubrik, notice: 'Rubrik was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rubrik.errors, status: :unprocessable_entity }
      end
    end
  end

  def verwalten
    @rubrik = Rubrik.find(params[:id])
    @neuigkeiten_unpublished = @rubrik.neuigkeiten.unpublished
    @neuigkeiten_published=@rubrik.neuigkeiten.published
    @moderatoren=User.with_role(:newsmoderator,@rubrik)
@toolbar_elements << {:text=>I18n.t('neuigkeit.new.title'),:path=> new_rubrik_neuigkeit_path(@rubrik),:hicon=>'icon-plus-sign'} if can? :verwalten, @rubrik


  end  

  # Alle Rubriken verwalten und Sachen einstellen..
  def alle_verwalten
    @rubriken =Rubrik.all
    @neuigkeiten_unpublished = Neuigkeit.unpublished
    @neuigkeiten_public_published = Neuigkeit.published.public

    @toolbar_elements << {:text=>I18n.t('common.new'),:path=>new_rubrik_path() ,:icon=>:plus} if can? :new, Rubrik

  end

  # DELETE /rubriken/1
  # DELETE /rubriken/1.json
  def destroy
    @rubrik = Rubrik.find(params[:id])
    @rubrik.destroy
    redirect_to rubriken_url
  end


end
