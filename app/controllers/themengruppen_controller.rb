class ThemengruppenController < ApplicationController
  # GET /themengruppen
  # GET /themengruppen.json
  def index
    @themengruppen = Themengruppe.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @themengruppen }
    end
  end

  # GET /themengruppen/1
  # GET /themengruppen/1.json
  def show
    @themagruppen = Themengruppe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @themagruppen }
    end
  end

  # GET /themengruppen/new
  # GET /themengruppen/new.json
  def new
    @themagruppen = Themengruppe.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @themagruppen }
    end
  end

  # GET /themengruppen/1/edit
  def edit
    @themagruppen = Themengruppe.find(params[:id])
  end

  # POST /themengruppen
  # POST /themengruppen.json
  def create
    @themagruppen = Themengruppe.new(params[:themagruppen])

    respond_to do |format|
      if @themagruppen.save
        format.html { redirect_to @themagruppen, notice: 'Themengruppe was successfully created.' }
        format.json { render json: @themagruppen, status: :created, location: @themagruppen }
      else
        format.html { render action: "new" }
        format.json { render json: @themagruppen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /themengruppen/1
  # PUT /themengruppen/1.json
  def update
    @themagruppen = Themengruppe.find(params[:id])

    respond_to do |format|
      if @themagruppen.update_attributes(params[:themagruppen])
        format.html { redirect_to @themagruppen, notice: 'Themengruppe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @themagruppen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themengruppen/1
  # DELETE /themengruppen/1.json
  def destroy
    @themagruppen = Themengruppe.find(params[:id])
    @themagruppen.destroy

    respond_to do |format|
      format.html { redirect_to themengruppen_url }
      format.json { head :no_content }
    end
  end
end
