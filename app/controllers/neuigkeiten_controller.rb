class NeuigkeitenController < ApplicationController
  before_filter {@toolbar_elements=[]}
  load_and_authorize_resource

  def show
  @neuigkeit = Neuigkeit.find(params[:id])
    @rubrik=@neuigkeit.rubrik    
    if  !params[:version].nil?
      @neuigkeit.assign_attributes(@neuigkeit.translation.versions.reverse[params[:version].to_i].reify.attributes.select{|k,v| @neuigkeit.translated_attribute_names.include? k.to_sym })
                                   
      # @neuigkeit=Neuigkeit.find(params[:id])
    end 
    @calentries1=@neuigkeit.calentries

      @toolbar_elements << {:hicon=>'icon-plus', :text=> I18n.t('neuigkeit.publish'),:path => publish_rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit),:confirm=>"Sure?" } if can? :publish, @neuigkeit
      @toolbar_elements << {:hicon=>'icon-minus', :text=> I18n.t('neuigkeit.unpublish'),:path => unpublish_rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit),:confirm=>"Sure?" } if can?(:unpublish, @neuigkeit) && !@neuigkeit.published?
     
 @toolbar_elements << {:text=>I18n.t('common.edit'),:path=>edit_rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit),:icon=>:pencil} if can? :edit, @neuigkeit.rubrik
      @versions= @neuigkeit.translation.versions.select([:created_at]).reverse
      @toolbar_elements <<{:path=>rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit),:method=>:versions,:versions=>@versions}
     
      @toolbar_elements << {:hicon=>'icon-remove-circle', :text=> I18n.t('common.delete'),:path => rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit), :method=> :delete,:confirm=>'Sure?' } if can? :delete, @neuigkeit
#      @toolbar_elements << {:path=> add_calentry_rubrik_neuigkeit_path(@neuigkeit.rubrik,@neuigkeit), :text=>"Add Calentry", :icon=>:plus}


  end
  
  def new
    @neuigkeit = Neuigkeit.new
    @rubrik=Rubrik.find(params[:rubrik_id]) unless params[:rubrik_id].nil?
    @neuigkeit.author=current_user
    @neuigkeit.rubrik=@rubrik unless @rubrik.nil?
    @calentries= [Calentry.new] 

  end
  def add_calentry
    @neuigkeit=Neuigkeit.find(params[:id])
    if params[:calentry_id].nil?
      ce = Calentry.new(:start=>Time.now, :ende=>1.hour.from_now, :typ=>1, :calendar=>@neuigkeit.rubrik.calendar)
    else
      ce=Calentry.find(params[:calentry_id])
    end
    @calentry=ce 
    ce.object=@neuigkeit
    @neuigkeit.calentry=ce
    @neuigkeit.save
    
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
    @calentries= @neuigkeit.calentries
    @calentries<<  Calentry.new 

  end

  def create
    @neuigkeit = Neuigkeit.new(params[:neuigkeit])
    @neuigkeit.author=current_user
    
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
