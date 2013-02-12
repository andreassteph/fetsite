class StudienController < ApplicationController

  def index
    @studien = Studium.all
   
  end

  def show
      @studium= Studium.find(params[:id])  
 end

  # GET /studia/new
  # GET /studia/new.json
  def new
    @studium = Studium.new
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


  def update
    @studium = Studium.find(params[:id])

    respond_to do |format|
      if @studium.update_attributes(params[:studium])
        format.html { redirect_to @studium, notice: 'Studium was successfully updated.' }
      
      else
        format.html { render action: "edit" }
  
      end
    end
  end

  # DELETE /studia/1
  # DELETE /studia/1.json
  def destroy
    @studium = Studium.find(params[:id])
    @studium.destroy
redirect_to studien_url
  end
end
