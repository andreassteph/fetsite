class NeuigkeitenController < ApplicationController
  # GET /neuigkeiten
  # GET /neuigkeiten.json
  def index
    @neuigkeiten = Neuigkeit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @neuigkeiten }
    end
  end

  # GET /neuigkeiten/1
  # GET /neuigkeiten/1.json
  def show
    @neuigkeit = Neuigkeit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @neuigkeit }
    end
  end

  # GET /neuigkeiten/new
  # GET /neuigkeiten/new.json
  def new
    @neuigkeit = Neuigkeit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @neuigkeit }
    end
  end

  # GET /neuigkeiten/1/edit
  def edit
    @neuigkeit = Neuigkeit.find(params[:id])
  end

  # POST /neuigkeiten
  # POST /neuigkeiten.json
  def create
    @neuigkeit = Neuigkeit.new(params[:neuigkeit])

    respond_to do |format|
      if @neuigkeit.save
        format.html { redirect_to @neuigkeit, notice: 'Neuigkeit was successfully created.' }
        format.json { render json: @neuigkeit, status: :created, location: @neuigkeit }
      else
        format.html { render action: "new" }
        format.json { render json: @neuigkeit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /neuigkeiten/1
  # PUT /neuigkeiten/1.json
  def update
    @neuigkeit = Neuigkeit.find(params[:id])

    respond_to do |format|
      if @neuigkeit.update_attributes(params[:neuigkeit])
        format.html { redirect_to @neuigkeit, notice: 'Neuigkeit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @neuigkeit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /neuigkeiten/1
  # DELETE /neuigkeiten/1.json
  def destroy
    @neuigkeit = Neuigkeit.find(params[:id])
    @neuigkeit.destroy

    respond_to do |format|
      format.html { redirect_to neuigkeiten_url }
      format.json { head :no_content }
    end
  end
end
