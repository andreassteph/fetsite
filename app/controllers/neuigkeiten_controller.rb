class NeuigkeitenController < ApplicationController

  def index
    @neuigkeiten = Neuigkeit.all
  end


  def show
    @neuigkeit = Neuigkeit.find(params[:id])

  end

  def new
    @neuigkeit = Neuigkeit.new
    @rubrik=Rubrik.find(params[:rubrik_id])
    @neuigkeit.rubrik=@rubrik
 end


  def edit
    @neuigkeit = Neuigkeit.find(params[:id])
  end

  def create
    @neuigkeit = Neuigkeit.new(params[:neuigkeit])

    respond_to do |format|
      if @neuigkeit.save
        format.html { redirect_to @neuigkeit, notice: 'Neuigkeit was successfully created.' }
     
      else
        format.html { render action: "new" }

      end
    end
  end


  def update
    @neuigkeit = Neuigkeit.find(params[:id])

    respond_to do |format|
      if @neuigkeit.update_attributes(params[:neuigkeit])
        format.html { redirect_to @neuigkeit, notice: 'Neuigkeit was successfully updated.' }

      else
        format.html { render action: "edit" }

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

    end
  end
end
