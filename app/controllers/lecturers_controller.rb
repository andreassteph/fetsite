class LecturersController < ApplicationController
  # GET /lecturers
  # GET /lecturers.json
  def index
    @lecturers = Lecturer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lecturers }
    end
  end

  # GET /lecturers/1
  # GET /lecturers/1.json
  def show
    @lecturer = Lecturer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lecturer }
    end
  end

  # GET /lecturers/new
  # GET /lecturers/new.json
  def new
    @lecturer = Lecturer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lecturer }
    end
  end

  # GET /lecturers/1/edit
  def edit
    @lecturer = Lecturer.find(params[:id])
  end

  # POST /lecturers
  # POST /lecturers.json
  def create
    @lecturer = Lecturer.new(params[:lecturer])

    respond_to do |format|
      if @lecturer.save
        format.html { redirect_to @lecturer, notice: 'Lecturer was successfully created.' }
        format.json { render json: @lecturer, status: :created, location: @lecturer }
      else
        format.html { render action: "new" }
        format.json { render json: @lecturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lecturers/1
  # PUT /lecturers/1.json
  def update
    @lecturer = Lecturer.find(params[:id])

    respond_to do |format|
      if @lecturer.update_attributes(params[:lecturer])
        format.html { redirect_to @lecturer, notice: 'Lecturer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lecturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lecturers/1
  # DELETE /lecturers/1.json
  def destroy
    @lecturer = Lecturer.find(params[:id])
    @lecturer.destroy

    respond_to do |format|
      format.html { redirect_to lecturers_url }
      format.json { head :no_content }
    end
  end
end
