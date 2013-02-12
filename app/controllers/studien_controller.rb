class StudienController < ApplicationController

  def index
    @studien = Studium.all
   
  end

  def show
    @studium= Studium.find(params[:id])
    @studienphasen=[]
   [1, 2 ,3].each do |ph| 
     modulgruppen_phase=@studium.modulgruppen.where(:phase=>ph)

     if modulgruppen_phase.count==1 
      opts={:width=>12, :slice=>1}
     elsif modulgruppen_phase.count <= 4 
      opts={:width=>6, :slice=>2}
     else 
      opts={:width=>4, :slice=>3}
     end  
     modulgruppen =[]
    modulgruppen_phase.each_slice(opts[:slice]) do |s| modulgruppen<<s end
    @studienphasen << {:modulgruppen=>modulgruppen, :phase => ph}.merge(opts)
  end
 end
 
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
