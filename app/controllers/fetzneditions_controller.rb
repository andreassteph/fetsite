class FetzneditionsController < ApplicationController
  # GET /fetzneditions
  # GET /fetzneditions.json
  def index
    @fetzneditions = Fetznedition.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fetzneditions }
    end
  end

  # GET /fetzneditions/1
  # GET /fetzneditions/1.json
  def show
    @fetznedition = Fetznedition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fetznedition }
    end
  end

  # GET /fetzneditions/new
  # GET /fetzneditions/new.json
  def new
    @fetznedition = Fetznedition.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fetznedition }
    end
  end

  # GET /fetzneditions/1/edit
  def edit
    @fetznedition = Fetznedition.find(params[:id])
  end

  # POST /fetzneditions
  # POST /fetzneditions.json
  def create
    @fetznedition = Fetznedition.new(params[:fetznedition])

    respond_to do |format|
      if @fetznedition.save
        format.html { redirect_to @fetznedition, notice: 'Fetznedition was successfully created.' }
        format.json { render json: @fetznedition, status: :created, location: @fetznedition }
      else
        format.html { render action: "new" }
        format.json { render json: @fetznedition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fetzneditions/1
  # PUT /fetzneditions/1.json
  def update
    @fetznedition = Fetznedition.find(params[:id])

    respond_to do |format|
      if @fetznedition.update_attributes(params[:fetznedition])
        format.html { redirect_to @fetznedition, notice: 'Fetznedition was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fetznedition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fetzneditions/1
  # DELETE /fetzneditions/1.json
  def destroy
    @fetznedition = Fetznedition.find(params[:id])
    @fetznedition.destroy

    respond_to do |format|
      format.html { redirect_to fetzneditions_url }
      format.json { head :no_content }
    end
  end
end
