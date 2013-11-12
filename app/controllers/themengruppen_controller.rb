class ThemengruppenController < ApplicationController
  # GET /themengruppen
  # GET /themengruppen.json
  load_and_authorize_resource
  def index
    @themengruppen = Themengruppe.order(:title)
    @toolbar_elements = [{:icon=>:plus, :hicon=>'icon-plus-sign', :text=>I18n.t('themengruppe.new'), :path=>new_themengruppe_path()}]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @themengruppen }
    end
  end

  # GET /themengruppen/1
  # GET /themengruppen/1.json
  def show
    @themengruppe = Themengruppe.find(params[:id])
    @toolbar_elements = [{:icon=>:plus, :hicon=>'icon-plus-sign', :text=>I18n.t('thema.add'), :path=>new_themengruppe_thema_path(@themengruppe)}]
    @toolbar_elements << {:icon=>:pencil, :hicon=>'icon-pencil', :text=>I18n.t('themengruppe.edit'), :path=>edit_themengruppe_path(@themengruppe)}
    @toolbar_elements << {:hicon=>'icon-remove-circle',:text=>I18n.t('themengruppe.remove'), :path=>themengruppe_path(@themengruppe), :method=>:delete,:confirm=>I18n.t('themengruppe.sure')}


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
