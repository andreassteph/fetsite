class RubrikenController < ApplicationController
  before_filter {@toolbar_elements=[]}
   load_and_authorize_resource
  def index
    @rubriken = Rubrik.all
    @neuigkeiten = Neuigkeit.recent
    @calentries= Calentry.all
  end
 
  def show
    @rubrik = Rubrik.find(params[:id])
    @moderatoren=User.with_role(:newsmoderator,@rubrik)
    if can?(:showunpublished, Neuigkeit)
    @neuigkeiten = @rubrik.neuigkeiten
else
    @neuigkeiten = @rubrik.neuigkeiten.published
end
@toolbar_elements << {:text=>I18n.t('neuigkeit.new.title'),:path=> new_rubrik_neuigkeit_path(@rubrik),:hicon=>'icon-plus-sign'} if can? :verwalten, @rubrik

@toolbar_elements << {:text=>I18n.t('common.verwalten'),:path=>verwalten_rubrik_path(@rubrik),:icon=>:pencil} if can? :verwalten, @rubrik
      


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
