class StudienController < ApplicationController
  before_filter {@toolbar_elements =[]} 


  def index
    @studien = Studium.all
    @toolbar_elements<<{:icon =>:plus, :hicon=>'icon-plus-sign', :text=> I18n.t('studien.new') ,:path=>new_studium_path }
    # @toolbar_elements<<{:text=> I18n.t('modulgruppe.show.link') ,:path=>modulgruppen_path }
  end

  def show
    @studium= Studium.find(params[:id])
    @text = 'Zu Semesteransicht wechseln'
    @path = studium_semesteransicht_path(@studium)
    
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
    	modulgruppen<<s #
      end
      @studienphasen << {:modulgruppen=>modulgruppen, :phase => ph}.merge(opts)
    end    
    @toolbar_elements=[{:icon=>:plus, :hicon =>'icon-plus-sign' ,:text=> I18n.t('studien.new') , :path => new_studium_path(@studium) }]
    @toolbar_elements<<{:icon=>:pencil, :hicon=>'icon-pencil',:text =>I18n.t('common.edit'),:path => edit_studium_path(@studium)}
    @toolbar_elements<<{:hicon=>'icon-remove-circle', :text=> I18n.t('common.delete'),:path => studium_path(@studium), :method=> :delete,:confirm=>"Sure?" }
    @toolbar_modulgruppen =[ {:hicon=>'icon-plus-sign', :text=> I18n.t('modulgruppe.new'), :path=>new_studium_modulgruppe_path(@studium)}]
    @toolbar_modulgruppen << {:hicon=>'icon-list', :text => I18n.t('modulgruppe.list'), :path=>modulgruppen_path}
  end

  def new
    @studium = Studium.new
  end

  def edit
    @studium = Studium.find(params[:id])
    @toolbar_elements=[{:text => I18n.t('studien.anzeigen') , :path => url_for(@studium) }]
    @toolbar_elements<<{:text =>I18n.t('studien.allestudien'),:path=>studien_path(@studium)}
  end

  def create
    @studium = Studium.new(params[:studium])
    
    respond_to do |format|
      if @studium.save
        @studium.batch_add_semester
        format.html { redirect_to url_for(@studium), notice: 'Studium was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end


  def update
    @studium = Studium.find(params[:id])

    if @studium.update_attributes(params[:studium])
      redirect_to url_for(@studium), notice: 'Studium was successfully updated.' 
    else
      render action: "edit" 
      
    end
    
  end
  def semesteransicht
    @sem = 'true'
    @studium = Studium.find(params[:id])
    if @studium.nil?
      @studium = Studium.first
    end
    @text = 'Zu Modulgruppenansicht wechseln'
    @path = studium_path(@studium)
    @toolbar_elements=[{:icon=>:plus, :hicon =>'icon-plus-sign' ,:text=> I18n.t('studien.new') , :path => new_studium_path(@studium) }]
    @toolbar_elements<<{:icon=>:pencil, :hicon=>'icon-pencil',:text =>I18n.t('common.edit'),:path => edit_studium_path(@studium)}
    @toolbar_elements<<{:hicon=>'icon-remove-circle', :text=> I18n.t('common.delete'),:path => studium_path(@studium), :method=> :delete,:confirm=>"Sure?" }
  end
  
  def destroy
    @studium = Studium.find(params[:id])
    @studium.destroy
    redirect_to studien_url
  end
end
