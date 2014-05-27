class ThemengruppenController < ApplicationController
  # GET /themengruppen
  # GET /themengruppen.json
  load_and_authorize_resource
  def index
    @themengruppen = Themengruppe.order(:priority).reverse
    @toolbar_elements = [{:icon=>:plus, :hicon=>'icon-plus-sign', :text=>I18n.t('themengruppe.new'), :path=>new_themengruppe_path()}]
    @toolbar_elements = [{:icon=>:plus, :hicon=>'icon-plus-sign', :text=>I18n.t('common.verwalten'), :path=>verwalten_all_themengruppen_path()}]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @themengruppen }
    end
  end
  def faqs
    @themengruppen = Themengruppe.order("themengruppen.priority").includes(:themen,{themen: :fragen}).order("themen.priority").reverse
    
  end

  # GET /themengruppen/1
  # GET /themengruppen/1.json
  def show
    @themengruppe = Themengruppe.find(params[:id])
    @themen = @themengruppe.themen.order(:priority).reverse
 
    @toolbar_elements = []
    @toolbar_elements << {:icon=>:plus, :hicon=>'icon-plus-sign', :text=>I18n.t('thema.add'), :path=>new_themengruppe_thema_path(@themengruppe)} if can? :new, Themengruppe
    @toolbar_elements << {:icon=>:pencil, :hicon=>'icon-pencil', :text=>I18n.t('themengruppe.edit'), :path=>edit_themengruppe_path(@themengruppe)} if can? :edit, @themengruppe
    @toolbar_elements << {:icon=>:pencil, :hicon=>'icon-pencil', :text=>I18n.t("themengruppe.manage"), :path=>themengruppe_verwalten_path(@themengruppe)} if can? :edit, @themengruppe
    @toolbar_elements << {:hicon=>'icon-remove-circle',:text=>I18n.t('themengruppe.remove'), :path=>themengruppe_path(@themengruppe), :method=>:delete,:confirm=>I18n.t('themengruppe.sure')} if can? :delete, @themengruppe

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @themengruppe }
    end
  end

  # GET /themengruppen/new
  # GET /themengruppen/new.json
  def new
    @themengruppe = Themengruppe.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @themengruppe }
    end
  end

  # GET /themengruppen/1/edit
  def edit
    @themengruppe = Themengruppe.find(params[:id])
  end
  def verwalten_all
    @themengruppen =Themengruppe.order(:priority).reverse
    @toolbar_elements = [{:icon=>:plus, :hicon=>'icon-plus-sign', :text=>I18n.t('themengruppe.new'), :path=>new_themengruppe_path()}]
 
 end 
  def verwalten 
      @themengruppe = Themengruppe.find(params[:themengruppe_id])
      @themen = @themengruppe.themen.order(:priority).reverse
  end

  def sort_themengruppen
    @params=params
    i=1
    params['themengruppen'].reverse.each do |themengruppeid|
      themengruppe=Themengruppe.find(themengruppeid)
      themengruppe.priority=i
      themengruppe.save
      i=i+1
    end
    respond_to do |format|
      format.js
    end 

  end

  def sort_themen
    @params=params
    i=1
    params['themen'].reverse.each do |themaid|
      thema=Thema.find(themaid)
      thema.priority=i
      thema.save
      i=i+1
    end
    respond_to do |format|
      format.js
    end 
  end

  # POST /themengruppen
  # POST /themengruppen.json
  def create
    @themengruppe = Themengruppe.new(params[:themengruppe])

    respond_to do |format|
      if @themengruppe.save
        format.html { redirect_to @themengruppe, notice: 'Themengruppe was successfully created.' }
        format.json { render json: @themengruppe, status: :created, location: @themengruppe }
      else
        format.html { render action: "new" }
        format.json { render json: @themengruppe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /themengruppen/1
  # PUT /themengruppen/1.json
  def update
    @themengruppe = Themengruppe.find(params[:id])

    respond_to do |format|
      if @themengruppe.update_attributes(params[:themengruppe])
        format.html { redirect_to @themengruppe, notice: 'Themengruppe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @themengruppe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themengruppen/1
  # DELETE /themengruppen/1.json
  def destroy
    @themengruppe = Themengruppe.find(params[:id])
    @themengruppe.destroy

    respond_to do |format|
      format.html { redirect_to themengruppen_url }
      format.json { head :no_content }
    end
  end
end
