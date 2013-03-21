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
    modulgruppen_phase.each_slice(opts[:slice]) do |s| 
	modulgruppen<<s 
	end
    	@studienphasen << {:modulgruppen=>modulgruppen, :phase => ph}.merge(opts)
    
	@toolbar_elements=[{:text => '<i class="icon-plus"></i> '.html_safe  + I18n.t('studien.new') , :path => new_studium_modulgruppe_path(@studium) }]
    	@toolbar_elements<<{:text => '<i class="icon-pencil"></i> '.html_safe + I18n.t('common.edit'),:path=>edit_studium_path(@studium)}
    	@toolbar_elements<<{:link=> link_to('Destroy', @studium, method: :delete, data: { confirm: 'Are you sure?' })}
 end
 end
 
  def new
    @studium = Studium.new
  end

  # GET /studia/1/edit
  def edit
    @studium = Studium.find(params[:id])
	@toolbar_elements=[{:text => I18n.t('studien.anzeigen') , :path => url_for(@studium) }]
	@toolbar_elements<<{:text =>I18n.t('studien.allestudien'),:path=>studien_path(@studium)}
  end

  # POST /studia
  # POST /studia.json
  def create
    @studium = Studium.new(params[:studium])

    respond_to do |format|
      if @studium.save
        format.html { redirect_to url_for(@studium), notice: 'Studium was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end


  def update
    @studium = Studium.find(params[:id])

    respond_to do |format|
      if @studium.update_attributes(params[:studium])
        format.html { redirect_to url_for(@studium), notice: 'Studium was successfully updated.' }
      
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
