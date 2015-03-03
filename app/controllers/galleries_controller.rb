class GalleriesController < ApplicationController
  before_filter {@toolbar_elements=[]}
  load_and_authorize_resource

  # GET /galleries
  # GET /galleries.json
  def index
    @galleries = Gallery.all
    @toolbar_elements << {:hicon => 'icon-plus', :text => I18n.t('fotos.new-gallery'), :path => new_gallery_path } if can? :new, Gallery

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galleries }
    end
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    @gallery = Gallery.find(params[:id])
    
    @pppage_array = [ 25 , 50 , 100, 10000] #defines number & size of picture chunks
    @pppage = 0 #starting index of pppage_array
    
    if !params[:pppage].nil? && params[:pppage].to_i <= 3 && params[:pppage].to_i >= 0
      @pppage = params[:pppage].to_i
    end
    
    @page = params[:page].nil? ? 1 : params[:page].to_i
   
      
    #  @fotos = Foto.where(:gallery_id => params[:id]).limit(@pppage_array[@pppage]).offset(@pppage_array[@pppage]*(@page-1))
    @fotos = Foto.where(:gallery_id => params[:id])
    unless params[:fotoid].nil?
      foto_ind = @fotos.find_index(Foto.find(params[:fotoid]))
     # @page=(@fotos.count/foto_ind).to_i+1
      @openfotoid=params[:fotoid]
    else
@openfotoid=0
    end
 if @fotos.nil? || @fotos.empty?
      @fotos_p = []
      @fotos_n = []
      @pages = 1
      
    else
      if @pppage_array[@pppage] != "all"
        @fotos_p = @fotos.page(@page).per(@pppage_array[@pppage])
        
        @fotos_n = @fotos- @fotos_p
        @foto_ind = @fotos.find_index(@fotos_p.first)
        @fotos_n = @fotos_n.rotate(@foto_ind)
        @pages = (Foto.where(:gallery_id => params[:id]).count/(@pppage_array[@pppage])+1)
      else
        @fotos_p = @fotos
        @fotos_n = []
        @pages = 1
      end
    end

    # Hier ausrechnen welche angezeigt werden sollen
    @toolbar_elements << {:hicon=>'icon-plus', :text=> I18n.t('fotos.new-fotos'), :path=>new_gallery_foto_path(@gallery)} if can? :create, @gallery
    @toolbar_elements << {:hicon=>'icon-pencil', :text => I18n.t('common.edit'), :path=>edit_gallery_path(@gallery)} if can? :edit, @gallery
    @toolbar_elements << {:hicon=>'icon-arrow-left', :text=>I18n.t('common.back'), :path=>galleries_path()} 
    @toolbar_elements << {:hicon => 'icon-remove-circle', :text => I18n.t('common.delete'), :path => gallery_path(@gallery),:confirm=>'Sure?', :method=>:delete} if can? :delete, Gallery
    
    respond_to do |format|
      format.html {
      if @fotos.nil? || @fotos.empty?
      redirect_to new_gallery_foto_path(@gallery)
      end
      }
      format.json { render json: @gallery }
    end
  end

  # GET /galleries/new
  # GET /galleries/new.json
  def new
    @gallery = Gallery.new
    @foto = Foto.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gallery }
    end
  end

  # GET /galleries/1/edit
  def edit
    @gallery = Gallery.find(params[:id])
    @fotos_old = @gallery.fotos
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(params[:gallery])
    @foto = Foto.new
    respond_to do |format|
      if @gallery.save
        format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
        format.json { render json: @gallery, status: :created, location: @gallery }
      else
        format.html { render action: "new" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /galleries/1
  # PUT /galleries/1.json
  def update
    @gallery = Gallery.find(params[:id])
    @foto = Foto.new
    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])

        Foto.where(:gallery_id=>nil).each do |tbd|
          tbd.destroy
        end
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to galleries_url }
      format.json { head :no_content }
    end
  end
end
