# -*- coding: utf-8 -*-
class ModulsController < ApplicationController
  # GET /moduls
  # GET /moduls.json
  before_filter :find_modul, :only=>[:show,:update,:update_lvas,:edit_lvas,:load_tiss,:show_tiss]          # @modul laden
  before_filter :load_toolbar_show, :only=>[:show]   # Toolbar für show erstellen
  before_filter :load_toolbar_index, :only=>[:index] # Toolbar für index erstellen
  load_and_authorize_resource

  before_filter :load_studien
  def load_studien
        @studien = Studium.accessible_by(current_ability, :show)
  end  
  def index
    @moduls = Modul.all
    if @moduls
      if !params[:studium_id].nil?
        @studium=Studium.find_by_id(params[:studium_id])
      end
      respond_to do |format|
        format.html # index.html.erb
      end
    end
    
  end

  # GET /moduls/1
  # GET /moduls/1.json
  def show
    for i in @modul.modulgruppen
      @tb <<{:text=> i.long_name, :path=>modulgruppe_path(i)} 
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
    end
  end

  def new_bulk
    @moduls= []
    @modulgruppe=Modulgruppe.find(params[:modulgruppen_id])
    10.times {@moduls << Modul.new(:modulgruppen=>[@modulgruppe])}
  end

  def edit
    @modul = Modul.find(params[:id])
    if !params[:studium_id].nil?
      @studium=Studium.find(params[:studium_id])
    end
  end

  def edit_bulk
    unless params[:modulgruppen_id].nil?
      @moduls=Modulgruppe.find(params[:modulgruppen_id]).moduls
    else
        unless params[:studium_id].nil?
         @moduls=Studium.find(params[:studium_id]).modulgruppen.collect(&:moduls).flatten
     else

    @moduls=Modul.all
end
    end
      
  end

  def edit_lvas
    @lvas = @modul.lvas
    @semester =  @modul.modulgruppen.flatten.map(&:studium).map(&:semester).flatten.uniq
  end

  def update

    respond_to do |format|
      if @modul.update_attributes(params[:modul])
        for i in @modul.lvas
          i.add_semesters
        end
        format.html { redirect_to url_for(@modul), notice: 'Modul was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def update_bulk 
    @moduls=Modul.update_multiple(params[:moduls])
    if @moduls.map(&:valid?).all?
      redirect_to @moduls.first.modulgruppen.first, :notice=>"Erfolgreich Module geändert"
    else
      render :edit_bulk
    end
  end



  def update_lvas
    @semester = @modul.modulgruppen.flatten.map(&:studium).map(&:semester).flatten.uniq
    @newlvas=Lva.update_multiple_with_modul(params["lvas"],@modul)
    @lvas=@newlvas

    if @newlvas.map(&:valid?).all?
      redirect_to modul_path(@modul)
    else
      render "edit_lvas"
     end
  end

  def load_tiss
    @lvas = @modul.lvas
  end

  def show_tiss
    @lvas=[];
    @semester = @modul.modulgruppen.flatten.map(&:studium).map(&:semester).flatten.uniq
    params["lvas"].to_a.each do |l|
     unless l.last["lvanr"].empty?
        l=l.last
       lva=Lva.new
        lva.lvanr=l["lvanr"]
       lva.load_tissdata("-"+ l["sem"])
       lva.modul<<@modul
       @lvas<<lva # 
      end 
    end
    render 'edit_lvas'
  end

  # GET /moduls/1/edit

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
      else
        format.html { render action: "new" }
      end
    end
    
  end

  # PUT /moduls/1
  # PUT /moduls/1.json
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

  private
  
  def find_modul
    @modul = Modul.find(params[:id])
  end

  def load_toolbar_show
    @toolbar_elements=[]
    @toolbar_elements << {:hicon=>'icon-plus-sign', :text=>I18n.t("lva.add"), :path=>new_lva_path(:modul_id =>@modul.id)} if can? :new, Lva
    @toolbar_elements << {:hicon=>'icon-pencil', :text=>"Lvas bearbeiten", :path=>edit_lvas_modul_path(@modul)} if can? :edit, Lva
    @toolbar_elements << {:hicon=>'icon-plus-sign', :text=>"ADD FROM TISS", :path=>load_tiss_modul_path(:modul_id =>@modul.id)} if can? :load_tiss, Modul
    @toolbar_elements << {:hicon=>'icon-pencil', :text=>I18n.t("modul.edit"), :path=>edit_modul_path(@modul)} if can? :edit, @modul
    @toolbar_elements << {:hicon=>'icon-remove-circle', :text=>I18n.t("common.delete"),:path=>@modul , :method=>:delete , :data=>{:confirm =>'Are you sure'}} if can? :delete, @modul
    @topbar_elements = [{:hicon=>'icon-list', :text=>I18n.t("modul.list"),:path=>moduls_path}]
    @tb=[]
    

    end
  
  def load_toolbar_index 

      @toolbar_elements = []
    @topbar_elements<<{:hicon=>'icon-plus-sign', :text=>I18n.t("modul.add"), :path=>new_modul_path} if can? :new , Modul
      @topbar_elements<< {:hicon=>'icon-list', :text=>I18n.t("studien.allestudien"),:path=>studien_path}
      @topbar_elements<<{:hicon=>'icon-list', :text=>I18n.t("modul.list"),:path=>moduls_path}
      @topbar_elements<<{:hicon=>'icon-list', :text=>I18n.t("lva.list"),:path=>lvas_path}

    end
 
  end
