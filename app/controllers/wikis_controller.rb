class WikisController < ApplicationController
  load_and_authorize_resource

  def show
    @wiki = Wiki.find(params[:id])
    @fragen = @wiki.fragen
    @toolbar_elements = [{:icon=>:pencil, :hicon=>'icon-pencil', :text=>I18n.t('wiki.edit'), :path=>verwalten_wiki_path(@wiki)}]
  end

  def wiki
    @wiki = Wiki.find_or_init(params[:name])
    @fragen = @wiki.fragen
    @toolbar_elements = []
#  @toolbar_elements = [{:icon=>:pencil, :hicon=>'icon-pencil', :text=>I18n.t('wiki.edit'), :path=>verwalten_wiki_path(@wiki)}]

    redirect_to wiki_path(@wiki)
  end

  def verwalten
    @wiki = Wiki.find(params[:id])
    @toolbar_elements = [{:icon=>:pencil, :hicon=>'icon-pencil', :text=>I18n.t('wiki.edit'), :path=>edit_wiki_path(@wiki)}]
    
  end
  def edit
    @wiki = Wiki.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end

  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @themen = @wiki.themengruppe.themen.order(:priority).reverse
    @wiki.raw_data=params[:wiki][:raw_data]
    respond_to do |format|
      if @wiki.update_attributes(params[:wiki])
        format.html { redirect_to @wiki, notice: 'Thema was successfully updated.' }
        format.json { head :no_content }
        format.js   
      else
        format.html { render action: "edit" }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
        format.js   { render action: "edit" }
      end
    end

  end
end
