class NeuigkeitenController < ApplicationController
  before_filter {@toolbar_elements=[]}
  load_and_authorize_resource

  def show
  @neuigkeit = Neuigkeit.find(params[:id])    
    if  !params[:version].nil?
      @neuigkeit.versions.reverse[params[:version].to_i].reify.save!
      @neuigkeit=Neuigkeit.find(params[:id])
    end 

    if params[:verwalten]
      @toolbar_elements << {:hicon=>'icon-plus', :text=> I18n.t('neuigkeit.publish'),:path => publish_rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit),:confirm=>"Sure?" } if can? :publish, @neuigkeit
      @toolbar_elements << {:hicon=>'icon-minus', :text=> I18n.t('neuigkeit.unpublish'),:path => unpublish_rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit),:confirm=>"Sure?" } if can? :unpublish, @neuigkeit
      @versions= @neuigkeit.versions.select([:created_at]).reverse
      @toolbar_elements <<{:path=>rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit),:method=>:versions,:versions=>@versions}
      @toolbar_elements << {:text=>I18n.t('common.edit'),:path=>edit_rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit),:icon=>:pencil} if can? :edit, @neuigkeit.rubrik
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
  def add_calentry
    @neuigkeit=Neuigkeit.find(params[:id])
    if params[:calentry_id].nil?
      ce = Calentry.new
    else
      ce=Calentry.find(params[:calentry_id])
    end
    @calentry=ce 
    ce.object=@neuigkeit
     render 'edit'
  end

  def unpublish
    @neuigkeit = Neuigkeit.find(params[:id])
    @neuigkeit.reverse_publish
    @neuigkeit.save
    if params[:verwalten] 
      redirect_to verwalten_rubrik_path(@neuigkeit.rubrik)
    end
    redirect_to rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit)
  end   
  def publish 
    @neuigkeit = Neuigkeit.find(params[:id])
    @neuigkeit.publish
    @neuigkeit.save
    if params[:verwalten] 
      redirect_to verwalten_rubrik_path(@neuigkeit.rubrik)
    end
    redirect_to rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit)
  end 

  def edit
    @neuigkeit = Neuigkeit.find(params[:id])
    @toolbar_elements << {:text=>I18n.t('common.show'),:path=>rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit)} if can? :show, @neuigkeit
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
        format.html { redirect_to [@neuigkeit.rubrik,@neuigkeit], notice: 'Neuigkeit was successfully updated.' }
      else
        format.html { render action: "edit" }  
      end
    end
  end
  
  # DELETE /neuigkeiten/1
  # DELETE /neuigkeiten/1.json
  def destroy
    @neuigkeit = Neuigkeit.find(params[:id])
    rubrik=@neuigkeit.rubrik
    @neuigkeit.destroy
    respond_to do |format|
      format.html { redirect_to rubrik }
      
    end
  end
end
