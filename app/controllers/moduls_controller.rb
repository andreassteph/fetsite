class ModulsController < ApplicationController
  # GET /moduls
  # GET /moduls.json
  def index
    @moduls = Modul.all
    if @moduls
      if !params[:studium_id].nil?
        @studium=Studium.find_by_id(params[:studium_id])
      end
      @toolbar_elements = [{:hicon=>'icon-plus-sign', :text=>I18n.t("modul.add"), :path=>new_modul_path}]
      @topbar_elements=[{:hicon=>'icon-list', :text=>I18n.t("studien.allestudien"),:path=>studien_path}]
      @topbar_elements<<{:hicon=>'icon-list', :text=>I18n.t("modul.list"),:path=>moduls_path}
      @topbar_elements<<{:hicon=>'icon-list', :text=>I18n.t("lva.list"),:path=>lvas_path}

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @moduls }
      end
    end
    
  end

  # GET /moduls/1
  # GET /moduls/1.json
  def show
    @modul = Modul.find(params[:id])
    @toolbar_elements = [{:hicon=>'icon-plus-sign', :text=>I18n.t("lva.add"), :path=>new_lva_path(:modul_id =>@modul.id)}]
    @toolbar_elements << {:hicon=>'icon-pencil', :text=>I18n.t("modul.edit"), :path=>edit_modul_path(@modul)}
    @toolbar_elements << {:hicon=>'icon-remove-circle', :text=>I18n.t("common.delete"),:path=>@modul , :method=>:delete , :data=>{:confirm =>'Are you sure'}}

    
    @topbar_elements = [{:hicon=>'icon-list', :text=>I18n.t("modul.list"),:path=>moduls_path}]
      @tb=[]
    for i in @modul.modulgruppen

      if  !i.studium.nil?
        name =i.studium.name
        id = i.studium.id
      else
        s.name = 'Kein Studium vorhanden'
        s.id = nil
      end
      @tb <<{:text=> i.name + ' ('+i.studium.name + ')', :path=>modulgruppe_path(i)} 
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @modul }
    end
  end

  # GET /moduls/new
  # GET /moduls/new.json
  def new
    @modul = Modul.new
    modulgruppe=Modulgruppe.find_by_id(params[:modulgruppen_id])
    if !modulgruppe.nil?
      @modul.modulgruppen<<modulgruppe #
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @modul }
    end
  end

  # GET /moduls/1/edit
  def edit
    @modul = Modul.find(params[:id])
    if !params[:studium_id].nil?
      @studium=Studium.find(params[:studium_id])
    end
  end

  # POST /moduls
  # POST /moduls.json
  def create
    @modul = Modul.new(params[:modul])
    
    
    respond_to do |format|
      if @modul.save
        for i in @modul.lvas
          i.add_semesters
        end
        format.html { redirect_to modulgruppe_path(@modul.modulgruppen.first), notice: 'Modul was successfully created.' }
        format.json { render json: @modul, status: :created, location: @modul }
      else
        format.html { render action: "new" }
        format.json { render json: @modul.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PUT /moduls/1
  # PUT /moduls/1.json
  def update
    @modul = Modul.find(params[:id])

    respond_to do |format|
      if @modul.update_attributes(params[:modul])
        for i in @modul.lvas
          i.add_semesters
        end
        format.html { redirect_to url_for(@modul), notice: 'Modul was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @modul.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moduls/1
  # DELETE /moduls/1.json
  def destroy
    
    @modul = Modul.find(params[:id])
    modulgruppe=@modul.modulgruppen.first
    for i in @modul.lvas
      i.add_semesters
    end
    @modul.destroy


    redirect_to modulgruppe_path(modulgruppe) 
    
  end
end
