class StudienController < ApplicationController
  before_filter {@toolbar_elements =[]} 
  #  before_filter :authorize, :only => :verwalten

  def index
    @studien = Studium.all
    @topbar_elements=[{:hicon=>'icon-list', :text=>I18n.t("studien.allestudien"),:path=>studien_path}]
    @topbar_elements<<{:hicon=>'icon-list', :text=>I18n.t("modul.list"),:path=>moduls_path}
    @topbar_elements<<{:hicon=>'icon-list', :text=>I18n.t("lva.list"),:path=>lvas_path}
    @toolbar_elements<<{:icon =>:plus, :hicon=>'icon-plus-sign', :text=> I18n.t('studien.new') ,:path=>new_studium_path }
    # @toolbar_elements<<{:text=> I18n.t('modulgruppe.show.link') ,:path=>modulgruppen_path }
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
        modulgruppen<<s #

      end
      @studienphasen << {:modulgruppen=>modulgruppen, :phase => ph}.merge(opts)
    end
    
    @toolbar_elements=[{:icon=>:plus, :hicon =>'icon-plus-sign' ,:text=> I18n.t('studien.new') , :path => new_studium_path(@studium) },
                       {:icon=>:pencil, :hicon=>'icon-pencil',:text =>I18n.t('common.edit'),:path => edit_studium_path(@studium)},
                       {:hicon=>'icon-remove-circle', :text=> I18n.t('common.delete'),:path => studium_path(@studium), :method=> :delete,:confirm=>"Sure?" }]

    @toolbar_modulgruppen =[ {:hicon=>'icon-plus-sign', :text=> I18n.t('modulgruppe.new'), :path=>new_studium_modulgruppe_path(@studium)},
                             {:hicon=>'icon-list', :text => I18n.t('modulgruppe.list'), :path=>modulgruppen_path}]
    
    if params[:ansicht] != 'modulgruppenansicht'
      @text = 'Zu Modulansicht wechseln'
      @flip = 'modulgruppenansicht'
      render 'semesteransicht'
    else
      @text = 'Zu Semesteransicht wechseln'
      @flip = 'semesteransicht'
    end
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

  def destroy
    @studium = Studium.find(params[:id])
    @studium.destroy
    redirect_to studien_url
  end

  def verwalten
    @new_params={:studium=>params[:studium], :modulgruppe=>params[:modulgruppe], :modul=>params[:modul], :lva=>params[:lva], :beispiel=>params[:beispiel]}
    
    if !@new_params[:studium].nil?
      @studien = [Studium.find(@new_params[:studium])]
    else
      @studien = Studium.all
    end
    if !@new_params[:modulgruppe].nil?
      @modulgruppen = [Modulgruppe.find(@new_params[:modulgruppe])]
      
    else
      @modulgruppen = Modulgruppe.all
    end
    if !@new_params[:modul].nil?
      @module = [Modul.find(@new_params[:modul])]
    else
      @module = Modul.all
    end
    if !@new_params[:lva].nil?
      @lvas = [Lva.find(@new_params[:lva])]
    else
      @lvas = Lva.all
    end
    if !@new_params[:beispiel].nil?
      @beispiele = [Beispiel.find(@new_params[:beispiel])]
    else
      @beispiele = Beispiel.all
    end
    
    render 'studien/verwalten'
  end
  
  def default_url_options
    {:ansicht=> params[:ansicht],
     :studium=> params[:studium],
     :modulgruppe=> params[:modulgruppe],
    :modul=>params[:modul],
    :lva=>params[:lva],
    :beispiel=>params[:beispiel]}.merge(super)

  end
end
