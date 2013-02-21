class RubrikenController < ApplicationController

  def index
    @rubriken = Rubrik.all
 
  end

 
  def show
    @rubrik = Rubrik.find(params[:id])
    @moderatoren=User.with_role(:newsmoderator,@rubrik)
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
  @moderatoren=User.with_role(:newsmoderator,@rubrik)
  end
  # DELETE /rubriken/1
  # DELETE /rubriken/1.json
  def destroy
    @rubrik = Rubrik.find(params[:id])
    @rubrik.destroy
    redirect_to rubriken_url
  end
end
