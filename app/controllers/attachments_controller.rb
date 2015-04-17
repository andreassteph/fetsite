class AttachmentsController < ApplicationController
  # GET /attachments
  # GET /attachments.json
  load_and_authorize_resource
  def index
#    @attachments = Attachment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attachments }
    end
  end

  # GET 
  # sets the titlepic flag for one attachment for one parent object
  def set_titlepic
    @attachment = Attachment.find(params[:id]) 
    if @attachment.image? # if attachment is an Image set flag
      @attachment.parent.attachments.update_all("flag_titlepic=0")
      @attachment.flag_titlepic=true
      @attachment.save
    end
   respond_to do |format|
      format.html { 
        redirect_to @attachment}
      format.js { 
        @parent=@attachment.parent
        @attachments=@parent.attachments
        render :refresh_list
      }
    end
  end
  # GET refresh_list
  # refresh the attachment list for a parent object
  def refresh_list
    @parent = params[:parent_type].constantize.find(params[:parent_id])
    @attachments=@parent.attachments
    respond_to do |format|
      format.js
    end   
  end
  #get /attachments/ID
  def show
    @attachment = Attachment.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
    @thema = Thema.find(params[:thema_id])
    @attachment.thema = @thema
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attachment }
      format.js
    end
  end

  # GET /attachments/1/edit 
  def edit
    @attachment = Attachment.find(params[:id])
    @thema = @attachment.thema
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = Attachment.new(params[:attachment])
    @thema = Thema.find_by_id(params[:thema_id])
   # logger.info "gg"
    @attachment.thema = @thema
    @attachment.name=@attachment.datei.filename
    @action="create"
 #   logger.info "sdf"
    respond_to do |format|
      if  @attachment.save
        format.html {
          render :json => [@attachment.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
  
      #  format.html { redirect_to @thema, notice: 'Attachment was successfully created.' }
        format.json { render json: {files: [@attachment.to_jq_upload]}, status: :created, location: [@thema, @attachment]}

      else
        format.html { render action: "new" }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }

      end
    end
  end

  # PUT /attachments/1
  # PUT /attachments/1.json
  def update
    @attachment = Attachment.find(params[:id])
    @parent= @attachment.parent
    
    respond_to do |format|
      if @attachment.update_attributes(params[:attachment])
        format.html { redirect_to @parent, notice: 'Attachment was successfully updated.' }
        format.json { head :no_content }
        format.js {@attachment=Attachment.new; render action:"create"}
      else
        format.html { render action: "edit" }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
        format.js   { render action: "new"}
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    @thema = Thema.find(params[:thema_id])

    respond_to do |format|
      format.html { redirect_to @thema }
      format.json { head :no_content }
    end
  end
end
