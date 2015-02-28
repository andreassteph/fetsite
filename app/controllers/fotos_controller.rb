class FotosController < ApplicationController
  before_filter {@toolbar_elements=[]}
  load_and_authorize_resource
  # GET /fotos
  # GET /fotos.json
  def index
    @fotos = Foto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fotos }
    end
  end

  # GET /fotos/1
  # GET /fotos/1.json
  def show
    @foto = Foto.find(params[:id])
    @gallery=@foto.gallery
    @openfotoid=@foto.id
    @pppage=params[:pppage].to_i % 4
    @pppage_array = [ 25 , 50 , 100, 10000]
   @page = params[:page].nil? ? 1 : params[:page].to_i
 
     @fotos_p = @gallery.fotos.page(@page).per(@pppage_array[@pppage])
    @fotos_n = @gallery.fotos- @fotos_p
    respond_to do |format|
      format.html {
        if params[:plain]
          render "show", layout: false
        else
          render "galleries/show" #controller: :galleries, action: :show #gallery_path(@foto.gallery,:params=>{fotoid: @foto.id})
        end
        }
      format.json { render json: @foto }
    end
  end

  # GET /fotos/new
  # GET /fotos/new.json
  def new
    @foto = Foto.new
    @gallery = Gallery.find_by_id(params[:gallery_id])
    @foto.gallery_id = @gallery.id
    @toolbar_elements << {:hicon => 'icon-arrow-left', :text => I18n.t('common.back'), :path => gallery_path(params[:gallery_id]) }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @foto }
    end
  end

  # GET /fotos/1/edit
  def edit
    @foto = Foto.find(params[:id])
  end

  # POST /fotos
  # POST /fotos.json
  def create
    @foto = Foto.new(params[:foto])
    @foto.gallery_id = (params[:gallery_id])
    @gallery = @foto.gallery
    respond_to do |format|
      @foto.title = @foto.datei.filename
      if @foto.save
       format.html {
          render :json => [@foto.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@foto.to_jq_upload]}, status: :created, location: [@gallery, @foto] }
      else
        format.html { render action: "new" }
        format.json { render json: @foto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fotos/1
  # PUT /fotos/1.json
  def update
    @foto = Foto.find(params[:id])

    respond_to do |format|
      if @foto.update_attributes(params[:foto])
        format.html {
          render :json => [@foto.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@foto.to_jq_upload]}, status: :created, location: [@gallery, @foto] }
      else
        format.html { render action: "edit" }
        format.json { render json: @foto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fotos/1
  # DELETE /fotos/1.json
  def destroy
    @foto = Foto.find(params[:id])
    gallery = @foto.gallery_id
    @foto.destroy

    respond_to do |format|
      format.html { redirect_to gallery_path(gallery) }
      format.json { head :no_content }
    end
  end
end
