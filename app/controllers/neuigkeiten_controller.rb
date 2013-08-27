class NeuigkeitenController < ApplicationController
 before_filter {@toolbar_elements=[]}
  load_and_authorize_resource
  #def index
  #  @neuigkeiten = Neuigkeit.all
  #end


  def show
    @neuigkeit = Neuigkeit.find(params[:id])
	if params[:verwalten]
    @toolbar_elements << {:hicon=>'icon-plus', :text=> "publish",:path => publish_rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit),:confirm=>"Sure?" } if can? :publish, @neuigkeit

	@toolbar_elements << {:text=>I18n.t('common.edit'),:path=>edit_rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit),:icon=>:pencil} if can? :edit, @neuigkeit
	@toolbar_elements << {:hicon=>'icon-remove-circle', :text=> I18n.t('common.delete'),:path => rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit), :method=> :delete,:confirm=>"Sure?" } if can? :delete, @neuigkeit
    else
    @toolbar_elements << {:text=>I18n.t('common.verwalten'),:path=>rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit,{:verwalten=>true}),:icon=>:pencil} if can? :verwalten, @neuigkeit

    end
  end

    def new
    @neuigkeit = Neuigkeit.new
    @rubrik=Rubrik.find(params[:rubrik_id]) unless params[:rubrik_id].nil?
    @neuigkeit.rubrik=@rubrik unless @rubrik.nil?
   end

   def publish 
    @neuigkeit = Neuigkeit.find(params[:id])
    @neuigkeit.publish
    @neuigkeit.save
    if params[:verwalten] 
		redirect_to verwalten_rubrik_path(@neuigkeit.rubrik)
    end
    redirect_to @neuigkeit

   end 
   def edit
    @neuigkeit = Neuigkeit.find(params[:id])
  end

  def create
    @neuigkeit = Neuigkeit.new(params[:neuigkeit])

 
    respond_to do |format|
      if @neuigkeit.save
        format.html { redirect_to [@neuigkeit.rubrik,@neuigkeit], notice: 'Neuigkeit was successfully created.' }
     
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
