class FetmeetingtopsController < ApplicationController
  # GET /fetmeetingtops
  # GET /fetmeetingtops.json
  def index
    @fetmeetingtops = Fetmeetingtop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fetmeetingtops }
    end
  end

  # GET /fetmeetingtops/1
  # GET /fetmeetingtops/1.json
  def show
    @fetmeetingtop = Fetmeetingtop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fetmeetingtop }
    end
  end

  # GET /fetmeetingtops/new
  # GET /fetmeetingtops/new.json
  def new
    @fetmeetingtop = Fetmeetingtop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fetmeetingtop }
    end
  end

  # GET /fetmeetingtops/1/edit
  def edit
    @fetmeetingtop = Fetmeetingtop.find(params[:id])
  end

  # POST /fetmeetingtops
  # POST /fetmeetingtops.json
  def create
    @fetmeetingtop = Fetmeetingtop.new(params[:fetmeetingtop])

    respond_to do |format|
      if @fetmeetingtop.save
        format.html { redirect_to @fetmeetingtop, notice: 'Fetmeetingtop was successfully created.' }
        format.json { render json: @fetmeetingtop, status: :created, location: @fetmeetingtop }
      else
        format.html { render action: "new" }
        format.json { render json: @fetmeetingtop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fetmeetingtops/1
  # PUT /fetmeetingtops/1.json
  def update
    @fetmeetingtop = Fetmeetingtop.find(params[:id])

    respond_to do |format|
      if @fetmeetingtop.update_attributes(params[:fetmeetingtop])
        format.html { redirect_to @fetmeetingtop, notice: 'Fetmeetingtop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fetmeetingtop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fetmeetingtops/1
  # DELETE /fetmeetingtops/1.json
  def destroy
    @fetmeetingtop = Fetmeetingtop.find(params[:id])
    @fetmeetingtop.destroy

    respond_to do |format|
      format.html { redirect_to fetmeetingtops_url }
      format.json { head :no_content }
    end
  end
end
