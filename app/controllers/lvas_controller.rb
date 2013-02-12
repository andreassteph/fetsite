class LvasController < ApplicationController
  # GET /lvas
  # GET /lvas.json
  def index
    @lvas = Lva.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lvas }
    end
  end

  # GET /lvas/1
  # GET /lvas/1.json
  def show
    @lva = Lva.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lva }
    end
  end

  # GET /lvas/new
  # GET /lvas/new.json
  def new
    @lva = Lva.new
    modul=Modul.find(params[:modul_id])
    @lva.modul<<modul
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lva }
    end
  end

  # GET /lvas/1/edit
  def edit
    @lva = Lva.find(params[:id])
  end

  # POST /lvas
  # POST /lvas.json
  def create
    @lva = Lva.new(params[:lva])
  
    respond_to do |format|
      if @lva.save
        format.html { redirect_to @lva, notice: 'Lva was successfully created.' }
        format.json { render json: @lva, status: :created, location: @lva }
      else
        format.html { render action: "new" }
        format.json { render json: @lva.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lvas/1
  # PUT /lvas/1.json
  def update
    @lva = Lva.find(params[:id])

    respond_to do |format|
      if @lva.update_attributes(params[:lva])
        format.html { redirect_to @lva, notice: 'Lva was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lva.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lvas/1
  # DELETE /lvas/1.json
  def destroy
    @lva = Lva.find(params[:id])
    @lva.destroy

    respond_to do |format|
      format.html { redirect_to lvas_url }
      format.json { head :no_content }
    end
  end
end
