class ModulsController < ApplicationController
  # GET /moduls
  # GET /moduls.json
  def index
   @moduls = Modul.all
   if !params[:studium_id].nil?
  @studium=Studium.find(params[:studium_id])
  end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @moduls }
    end
  end

  # GET /moduls/1
  # GET /moduls/1.json
  def show
    @modul = Modul.find(params[:id])

      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @modul }
    end
  end

  # GET /moduls/new
  # GET /moduls/new.json
  def new
    @modul = Modul.new
    modulgruppe=Modulgruppe.find(params[:modulgruppen_id])
    @modul.modulgruppen<<modulgruppe
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @modul }
    end
  end

  # GET /moduls/1/edit
  def edit
    @modul = Modul.find(params[:id])
     if !params[:studium_id].nil?
  @studium=Studium.find(params[:studium_id])
  end
  end

  # POST /moduls
  # POST /moduls.json
  def create
    @modul = Modul.new(params[:modul])
   
    
   respond_to do |format|
     if @modul.save
        format.html { redirect_to modulgruppe_path(@modul.modulgruppen.first), notice: 'Modul was successfully created.' }
        format.json { render json: @modul, status: :created, location: @modul }
     else
        format.html { render action: "new" }
        format.json { render json: @modul.errors, status: :unprocessable_entity }
     end
     end
   
  end

  # PUT /moduls/1
  # PUT /moduls/1.json
  def update
    @modul = Modul.find(params[:id])

    respond_to do |format|
      if @modul.update_attributes(params[:modul])
        format.html { redirect_to url_for(@modul), notice: 'Modul was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @modul.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moduls/1
  # DELETE /moduls/1.json
  def destroy
    
    @modul = Modul.find(params[:id])
    modulgruppe=@modul.modulgruppen.first
    @modul.destroy


    redirect_to modulgruppe_path(modulgruppe) 
    
  end
end
