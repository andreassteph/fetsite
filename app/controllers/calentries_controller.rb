class CalentriesController < ApplicationController
  # GET /calentries
  # GET /calentries.json
  def index
    @calentries = Calentry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calentries }
    end
  end

  # GET /calentries/1
  # GET /calentries/1.json
  def show
    @calentry = Calentry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calentry }
      format.ics  { render 'show.ics.erb'}
    end
  end

  # GET /calentries/new
  # GET /calentries/new.json
  def new
    @calentry = Calentry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calentry }
    end
  end

  # GET /calentries/1/edit
  def edit
    @calentry = Calentry.find(params[:id])
  end

  # POST /calentries
  # POST /calentries.json
  def create
    @calentry = Calentry.new(params[:calentry])

    respond_to do |format|
      if @calentry.save
        format.html { redirect_to @calentry, notice: 'Calentry was successfully created.' }
        format.json { render json: @calentry, status: :created, location: @calentry }
      else
        format.html { render action: "new" }
        format.json { render json: @calentry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calentries/1
  # PUT /calentries/1.json
  def update
    @calentry = Calentry.find(params[:id])

    respond_to do |format|
      if @calentry.update_attributes(params[:calentry])
        format.html { redirect_to @calentry, notice: 'Calentry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @calentry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calentries/1
  # DELETE /calentries/1.json
  def destroy
    @calentry = Calentry.find(params[:id])
    @calentry.destroy

    respond_to do |format|
      format.html { redirect_to calentries_url }
      format.json { head :no_content }
    end
  end
end
