class FetprofilesController < ApplicationController
  # GET /fetprofiles
  # GET /fetprofiles.json
  def index
    
    @fetprofiles = Fetprofile.active
    @fetprofiles = Fetprofile.order(:vorname,:nachname) if params[:filter]== "all"
	@gremientabs=Gremium.order(:typ)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fetprofiles }
    end
  end

  # GET /fetprofiles/1
  # GET /fetprofiles/1.json
  def show
    @fetprofile = Fetprofile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fetprofile }
    end
  end

  # GET /fetprofiles/new
  # GET /fetprofiles/new.json
  def new
    @fetprofile = Fetprofile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fetprofile }
    end
  end

  # GET /fetprofiles/1/edit
  def edit
    @fetprofile = Fetprofile.find(params[:id])
  end

  # POST /fetprofiles
  # POST /fetprofiles.json
  def create
    @fetprofile = Fetprofile.new(params[:fetprofile])

    respond_to do |format|
      if @fetprofile.save
        format.html { redirect_to @fetprofile, notice: 'Fetprofile was successfully created.' }
        format.json { render json: @fetprofile, status: :created, location: @fetprofile }
      else
        format.html { render action: "new" }
        format.json { render json: @fetprofile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fetprofiles/1
  # PUT /fetprofiles/1.json
  def update
    @fetprofile = Fetprofile.find(params[:id])

    respond_to do |format|
      if @fetprofile.update_attributes(params[:fetprofile])
        format.html { redirect_to @fetprofile, notice: 'Fetprofile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fetprofile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fetprofiles/1
  # DELETE /fetprofiles/1.json
  def destroy
    @fetprofile = Fetprofile.find(params[:id])
    @fetprofile.destroy

    respond_to do |format|
      format.html { redirect_to fetprofiles_url }
      format.json { head :no_content }
    end
  end
end
