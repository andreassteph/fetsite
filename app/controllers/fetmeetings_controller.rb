class FetmeetingsController < ApplicationController
  # GET /fetmeetings
  # GET /fetmeetings.json
  def index
    @fetmeetings = Fetmeeting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fetmeetings }
    end
  end

  # GET /fetmeetings/1
  # GET /fetmeetings/1.json
  def show
    @fetmeeting = Fetmeeting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fetmeeting }
    end
  end

  # GET /fetmeetings/new
  # GET /fetmeetings/new.json
  def new
    @fetmeeting = Fetmeeting.new
    @fetmeeting.calentry=Calentry.new(typ: 0, object: @fetmeetings)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fetmeeting }
    end
  end

  # GET /fetmeetings/1/edit
  def edit
    @fetmeeting = Fetmeeting.find(params[:id])
 
  end

  # POST /fetmeetings
  # POST /fetmeetings.json
  def create
    @fetmeeting = Fetmeeting.new(params[:fetmeeting])

    respond_to do |format|
      if @fetmeeting.save
        format.html { redirect_to @fetmeeting, notice: 'Fetmeeting was successfully created.' }
        format.json { render json: @fetmeeting, status: :created, location: @fetmeeting }
      else
        format.html { render action: "new" }
        format.json { render json: @fetmeeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fetmeetings/1
  # PUT /fetmeetings/1.json
  def update
    @fetmeeting = Fetmeeting.find(params[:id])

    respond_to do |format|
      if @fetmeeting.update_attributes(params[:fetmeeting])
        format.html { redirect_to @fetmeeting, notice: 'Fetmeeting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fetmeeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fetmeetings/1
  # DELETE /fetmeetings/1.json
  def destroy
    @fetmeeting = Fetmeeting.find(params[:id])
    @fetmeeting.destroy

    respond_to do |format|
      format.html { redirect_to fetmeetings_url }
      format.json { head :no_content }
    end
  end
end
