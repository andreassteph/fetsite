class MembershipsController < ApplicationController
  # GET /memberships/new
  # GET /memberships/new.json
  def new
    @membership = Membership.new
	@membership.fetprofile=Fetprofile.find(params[:fetprofile_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/1/edit
  def edit
    @membership = Membership.find(params[:id])
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(params[:membership])
    @membership.fetprofile= Fetprofile.find(params[:fetprofile_id])
    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership.fetprofile, notice: 'Membership was successfully created.' }
        format.json { render json: @membership.fetprofile, status: :created, location: @membership.fetprofile }
      else
        format.html { render action: "new" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /memberships/1
  # PUT /memberships/1.json
  def update
    @membership = Membership.find(params[:id])

    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        format.html { redirect_to @membership.fetprofile, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership = Membership.find(params[:id])
    fp = @membership.fetprofile
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to fp }
      format.json { head :no_content }
    end
  end
end
