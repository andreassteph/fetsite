class DocumentsController < ApplicationController
# require('etherpad-lite')
  load_and_authorize_resource
  def index
    respond_to do |format|
      format.html {redirect_to rubriken_path}
    end
  end
  def new
    @document=Document.new
    @parent=params[:parent_type].constantize.find(params[:parent_id])
    @document.parent=@parent

    @document.typ = 1
    respond_to do |format|
      format.js
    end
  end
  def edit
    @document = Document.find(params[:id])
    @parent=@document.parent
    respond_to do |format|
      format.js
      format.html
    end
  end
  def sanitize
    @document = Document.find(params[:id])
    @document.sanitize
    @parent=@document.parent
    render :edit
  end
  def show
    @document = Document.find(params[:id])
    respond_to do |format|
       format.pdf { send_file @document.create_pdf.path }
      format.html
    end
  end

  def dump_to_etherpad
    @document = Document.find(params[:id])
    @document.dump_to_etherpad
@document.save
#    author = ether.author('author_1')
#    pad=group.pad(@document.etherpadkey)
#    pad.html='<div>'+@document.text+'</div>'
    redirect_to action: :show
  end
  def read_from_etherpad
    @document = Document.find(params[:id])
    @document.read_from_etherpad
    @document.save
    render :show
  end

  def write_etherpad
    @document = Document.find(params[:id])
    
    ether=Document.ether
    author = Document.ether.author("fetsite_"+current_user.uid, :name => current_user.text)
    session[:ep_sessions]={} if session[:ep_sessions].nil?
    group=@document.ep_group

    sess = session[:ep_sessions][group.id] ? ether.get_session(session[:ep_sessions][group.id]) : group.create_session(author, 300)
    
    if sess.expired?
      sess.delete
      sess = group.create_session(author, 300)
    end
    session[:ep_sessions][group.id] = sess.id
    # Set the EtherpadLite session cookie. This will automatically be picked up by the jQuery plugin's iframe.

    cookies[:sessionID] = {value: sess.id.to_s, domain: %w(.fet.at), expires: 5.hour.from_now}
    #cookies[:sessionID] = {:value => sess.id}
    cookies[:sessionID]= {value: sess.id, expires: 5.hour.from_now}
#    cookies[:sdf]=sess.id
    # pad=ether.pad(@document.etherpadkey)
  #  redirect_to "http://www.fet.at/etherpad/p/"+@document.ep_pad.id
    #render :write
  end
  def write
    @document = Document.find(params[:id])
    if @document.is_etherpad? && params[:versionid].nil?
      redirect_to action: :write_etherpad
    else
      unless params[:versionid].nil?
        v=@document.versions.find(params[:versionid])
        if v.reify.nil?
          v=v.next
        end
        @document=v.reify
       
      end
      @parent=@document.parent
      respond_to do |format|
        format.html
      end
    end
  end

  def create
    @document = Document.new(params[:document])

    @parent=@document.parent

    respond_to do |format|
      if @document.save
       # format.html { redirect_to @document, notice: 'Document was successfully created.' }
        #format.json { render json: @document, status: :created, location: @document }
        format.js
      else
    #    format.html { render action: "new" }
   #     format.json { render json: @document.errors, status: :unprocessable_entity }
        format.js { render action: "new" }
      end
    end
  end


  def update
    @document = Document.find(params[:id])
    @parent=@document.parent

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
     #   format.html { render action: "edit" }
    #    format.json { render json: @document.errors, status: :unprocessable_entity }
        format.js { render action: "edit"}
      end
    end
  end
  def destroy
    logger.info("-------------delete------------------")
    @document = Document.find(params[:id])

    @parent=@document.parent

    @document_id = params[:id]  
   
    @document.destroy
    
    respond_to do |format|
      #format.html { redirect_to @object}
      #format.json { head :no_content }
      format.js 
    end
  end

  def search
  
    unless params['query'].nil? || params['query'].empty?
      @results = Document.search do
        fulltext params['query'] do
          highlight :name, :text
        end
      end
      @res=[]
      @results.results.each do |r|
        @res << r if can?(:show,r)
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

end
