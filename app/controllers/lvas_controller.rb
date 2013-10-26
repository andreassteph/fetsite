class LvasController < ApplicationController
  # GET /lvas
 before_filter {@toolbar_elements =[]} 
  load_and_authorize_resource
  def index
    @lvas = Lva.all
    @toolbar_elements=[{:hicon=>'icon-plus-sign',:text =>I18n.t('lva.add'),:path => new_lva_path}]
    @tb=[{:hicon=>'icon-list', :text=>I18n.t("studien.allestudien"),:path=>studien_path},
         {:hicon=>'icon-list', :text=>I18n.t("modul.list"),:path=>moduls_path},
         {:hicon=>'icon-list', :text=>I18n.t("lva.list"),:path=>lvas_path}]
  end

  # GET /lvas/1

  def show
    @lva = Lva.find_by_id(params[:id])
   
    @toolbar_elements<<{:hicon=>'icon-plus-sign', :icon=>:plus, :text => "Neues Beispiel", :path=> new_beispiel_path(:lva_id =>@lva.id)}
     @toolbar_elements<<{:hicon=>'icon-pencil', :icon=>:pencil,:text =>I18n.t('common.edit'),:path => edit_lva_path(@lva)}
    @toolbar_elements << {:hicon=>'icon-remove-circle', :text=>I18n.t('common.delete'), :path=> lva_path(@lva), :method=>:delete, :confirm=>"Sure?"}
  end

  # GET /lvas/new
  # GET /lvas/new.json
  def new
    @lva = Lva.new
    modul=Modul.find_by_id(params[:modul_id])
    @lva.modul<<modul unless modul.nil? #
    
  end

  # GET /lvas/1/edit
  def edit
    @lva = Lva.find(params[:id])
  end

  # POST /lvas
  # POST /lvas.json
  def create
    @lva = Lva.new(params[:lva])
 
    respond_to do |format|
      if @lva.save
         @lva.add_semesters
        format.html { redirect_to @lva, notice: 'Lva was successfully created.' }
        
      else
        format.html { render action: "new" }
        
      end
    end
  end

  # PUT /lvas/1
  # PUT /lvas/1.json
  def update
    @lva = Lva.find(params[:id])
    
    respond_to do |format|
      if @lva.update_attributes(params[:lva])
        @lva.add_semesters
        format.html { redirect_to @lva, notice: 'Lva was successfully updated.' }
 
      else
        format.html { render action: "edit" }

      end
    end
  end

  # DELETE /lvas/1
  # DELETE /lvas/1.json
  def destroy
    @lva = Lva.find(params[:id])
    @lva.destroy

    respond_to do |format|
      format.html { redirect_to lvas_url }
   
    end
  end
end
