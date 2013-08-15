class NeuigkeitenController < ApplicationController
 before_filter {@toolbar_elements=[]}
  load_and_authorize_resource
  def index
    @neuigkeiten = Neuigkeit.all
  end


  def show
    @neuigkeit = Neuigkeit.find(params[:id])
    if can? :edit, @neuigkeit
	@toolbar_elements << {:text=>I18n.t('common.edit'),:path=>edit_neuigkeit_path(@neuigkeit),:icon=>:pencil}
    end
  end

  def new
    @neuigkeit = Neuigkeit.new
    @rubrik=Rubrik.find(params[:rubrik_id]) unless params[:rubrik_id].nil?
    @neuigkeit.rubrik=@rubrik unless @rubrik.nil?
 end


  def edit
    @neuigkeit = Neuigkeit.find(params[:id])
  end

  def create
    @neuigkeit = Neuigkeit.new(params[:neuigkeit])
	@rubrik = @neuigkeit.rubrik
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
