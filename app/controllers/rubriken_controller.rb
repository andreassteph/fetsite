class RubrikenController < ApplicationController
  # GET /rubriken
  # GET /rubriken.json
  def index
    @rubriken = Rubrik.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rubriken }
    end
  end

  # GET /rubriken/1
  # GET /rubriken/1.json
  def show
    @rubrik = Rubrik.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rubrik }
    end
  end

  # GET /rubriken/new
  # GET /rubriken/new.json
  def new
    @rubrik = Rubrik.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rubrik }
    end
  end

  # GET /rubriken/1/edit
  def edit
    @rubrik = Rubrik.find(params[:id])
  end

  # POST /rubriken
  # POST /rubriken.json
  def create
    @rubrik = Rubrik.new(params[:rubrik])

    respond_to do |format|
      if @rubrik.save
        format.html { redirect_to @rubrik, notice: 'Rubrik was successfully created.' }
        format.json { render json: @rubrik, status: :created, location: @rubrik }
      else
        format.html { render action: "new" }
        format.json { render json: @rubrik.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rubriken/1
  # PUT /rubriken/1.json
  
  def addmoderator
    @rubrik = Rubrik.find(params[:id])
    if current_user.has_role?(:newsadmin,@rubrik) || current_user.has_role?(:newsadmin)
      User.find(params[:userid]).add_role(:newsmoderator, @rubrik)
    end
    respond_to do |format|
      format.html { redirect_to @rubrik }
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

  # DELETE /rubriken/1
  # DELETE /rubriken/1.json
  def destroy
    @rubrik = Rubrik.find(params[:id])
    @rubrik.destroy

    respond_to do |format|
      format.html { redirect_to rubriken_url }
      format.json { head :no_content }
    end
  end
end
