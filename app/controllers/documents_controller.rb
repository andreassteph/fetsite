class DocumentsController < ApplicationController

  load_and_authorize_resource
  def index
    respond_to do |format|
      format.html {redirect_to rubriken_path}
    end
  end
  def new
    @document=Document.new
    @document.parent=params[:parent_typ].constantize.find(params[:parent_id])
    @document.typ = 1
    respond_to do |format|
      format.js
    end
  end
  def edit
    @document = Document.find(params[:id])
    respond_to do |format|
       format.js
    end

  end

  def create
    @document = Document.new(params[:document])

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
    @document_id = params[:id]  
   
    @document.destroy
    
    respond_to do |format|
      #format.html { redirect_to @object}
      #format.json { head :no_content }
      format.js 
    end
  end


end
