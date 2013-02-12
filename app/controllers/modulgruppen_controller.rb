class ModulgruppenController < ApplicationController
  # GET /modulgruppen
  # GET /modulgruppen.json

  load_and_authorize_resource
  def index
    @modulgruppen = Modulgruppe.all
 if !params[:studium_id].nil?
  @studium=Studium.find(params[:studium_id])
  end

  end

  # GET /modulgruppen/1
  # GET /modulgruppen/1.json
  def show
    @modulgruppe = Modulgruppe.find(params[:id])
 if !params[:studium_id].nil?
  @studium=Studium.find(params[:studium_id])
  end

  end

  # GET /modulgruppen/new
  # GET /modulgruppen/new.json
  def new
    @modulgruppe = Modulgruppe.new
 if !params[:studium_id].nil?
  @studium=Studium.find(params[:studium_id])
  end

  end

  # GET /modulgruppen/1/edit
  def edit
    @modulgruppe = Modulgruppe.find(params[:id])
    if !params[:studium_id].nil?
  @studium=Studium.find(params[:studium_id])
  end
  end

  # POST /modulgruppen
  # POST /modulgruppen.json
  def create
    @modulgruppe = Modulgruppe.new(params[:modulgruppe])
   if !params[:studium_id].nil?
      @studium=Studium.find(params[:studium_id]) 
    else
      @studium=Studium.find(params[:modulgruppe][:studium_id]) 
   end
    respond_to do |format|
      if @modulgruppe.save
        format.html { redirect_to @modulgruppe, notice: 'Modulgruppe was successfully created.' }
        format.json { render json: @modulgruppe, status: :created, location: @modulgruppe }
      else
        format.html { render action: "new" }
        format.json { render json: @modulgruppe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /modulgruppen/1
  # PUT /modulgruppen/1.json
  def update
    @modulgruppe = Modulgruppe.find(params[:id])

    respond_to do |format|
      if @modulgruppe.update_attributes(params[:modulgruppe])
        format.html { redirect_to @modulgruppe, notice: 'Modulgruppe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @modulgruppe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modulgruppen/1
  # DELETE /modulgruppen/1.json
  def destroy
    @modulgruppe = Modulgruppe.find(params[:id])
    @modulgruppe.destroy

    respond_to do |format|
      format.html { redirect_to modulgruppen_url }
      format.json { head :no_content }
    end
  end
end
