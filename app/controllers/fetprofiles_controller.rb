class FetprofilesController < ApplicationController
  # GET /fetprofiles
  # GET /fetprofiles.json
  before_filter {@toolbar_elements=[]}
  load_and_authorize_resource
 
  
  def index
    
    @fetprofiles = Fetprofile.active.order(:vorname,:nachname)
    @fetprofiles = Fetprofile.order(:vorname,:nachname) if params[:filter]== "all"
    @gremientabs = Gremium.tabs
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fetprofiles }
    end
  end

  # GET /fetprofiles/1
  # GET /fetprofiles/1.json
  def show
    @fetprofile = Fetprofile.find(params[:id])
    @gremientabs = Gremium.tabs
    @memberships=@fetprofile.memberships.order(:typ)
    @memberships<<Membership.new
    
    if params["verwalten"]
      @toolbar_elements << {:hicon=>'icon-plus', :text=> I18n.t('fetprofile.newmembership'),:path => new_fetprofile_membership_path(@fetprofile) , :confirm=>"Sure?" } if can? :new, Membership
     @toolbar_elements << {:hicon=>'icon-pencil', :text=> I18n.t('common.edit'),:path => edit_fetprofile_path(@fetprofile),:confirm=>"Sure?" } if can? :edit, @fetprofile
      @toolbar_elements << {:hicon=>'icon-minus', :text => I18n.t('common.delete'), :method=>:delete, :confirm=>"Sure"}
          
    else
      @toolbar_elements << {:text=>I18n.t('common.verwalten'),:path=>fetprofile_path(@fetprofile,{:verwalten=>true}),:icon=>:pencil} if can? :verwalten, @fetprofile
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fetprofile }
    end
  end

  # GET /fetprofiles/new
  # GET /fetprofiles/new.json
  def new
    @fetprofile = Fetprofile.new
    @memberships=[]
    @memberships<<Membership.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fetprofile }
    end
  end

  # GET /fetprofiles/1/edit
  def edit
    @fetprofile = Fetprofile.find(params[:id])
    @memberships=@fetprofile.memberships.order(:typ)
    @memberships<<Membership.new
  end

  # POST /fetprofiles
  # POST /fetprofiles.json
  def create
    @fetprofile = Fetprofile.new(params[:fetprofile])
    @memberships=@fetprofile.memberships.order(:typ)
    @memberships<<Membership.new

    respond_to do |format|
      if @fetprofile.save
        format.html { redirect_to @fetprofile, notice: 'Fetprofile was successfully created.' }
        format.json { render json: @fetprofile, status: :created, location: @fetprofile }
      else
        format.html { render action: "new" }
        format.json { render json: @fetprofile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fetprofiles/1
  # PUT /fetprofiles/1.json
  def update
    @fetprofile = Fetprofile.find(params[:id])
    @memberships=@fetprofile.memberships.order(:typ)
    @memberships<<Membership.new

    respond_to do |format|
      if @fetprofile.update_attributes(params[:fetprofile])
        format.html { redirect_to @fetprofile, notice: 'Fetprofile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fetprofile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fetprofiles/1
  # DELETE /fetprofiles/1.json
  def destroy
    @fetprofile = Fetprofile.find(params[:id])
    @fetprofile.destroy

    respond_to do |format|
      format.html { redirect_to fetprofiles_url }
      format.json { head :no_content }
    end
  end
end
