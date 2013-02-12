class StudienController < ApplicationController
  # GET /studia
  # GET /studia.json
  def index
    @studien = Studium.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @studien }
    end
  end

  # GET /studia/1
  # GET /studia/1.json
  def show
    
      @studium= Studium.find(params[:id])
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @studium }
    end
  end

  # GET /studia/new
  # GET /studia/new.json
  def new
    @studium = Studium.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @studium }
    end
  end

  # GET /studia/1/edit
  def edit
    @studium = Studium.find(params[:id])
  end

  # POST /studia
  # POST /studia.json
  def create
    @studium = Studium.new(params[:studium])

    respond_to do |format|
      if @studium.save
        format.html { redirect_to @studium, notice: 'Studium was successfully created.' }
        format.json { render json: @studium, status: :created, location: @studium }
      else
        format.html { render action: "new" }
        format.json { render json: @studium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /studia/1
  # PUT /studia/1.json
  def update
    @studium = Studium.find(params[:id])

    respond_to do |format|
      if @studium.update_attributes(params[:studium])
        format.html { redirect_to @studium, notice: 'Studium was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @studium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /studia/1
  # DELETE /studia/1.json
  def destroy
    @studium = Studium.find(params[:id])
    @studium.destroy

    respond_to do |format|
      format.html { redirect_to studien_url }
      format.json { head :no_content }
    end
  end
end
