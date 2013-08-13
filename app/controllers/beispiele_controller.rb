class BeispieleController < ApplicationController
  # GET /beispiele
  # GET /beispiele.json
  def index
    @beispiele = Beispiel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beispiele }
    end
  end

  # GET /beispiele/1
  # GET /beispiele/1.json
  def show
    # @lva = params([:lva]) unless params([:lva]).nil?
    @beispiel = Beispiel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beispiel }
    end
  end

  # GET /beispiele/new
  # GET /beispiele/new.json
  def new
    @beispiel = Beispiel.new
    @beispiel.lva = Lva.find(params[:lva_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beispiel }
    end
  end

  # GET /beispiele/1/edit
  def edit
    @beispiel = Beispiel.find(params[:id])
  end

  # POST /beispiele
  # POST /beispiele.json
  def create
    lvaid=params[:lva_id]
    params.delete(:lva_id)
    @beispiel = Beispiel.new(params[:beispiel])
    respond_to do |format|
      if @beispiel.save
        format.html { redirect_to @beispiel, notice: 'Beispiel was successfully created.' }
        format.json { render json: @beispiel, status: :created, location: @beispiel }
      else
        format.html { render action: "new" }
        format.json { render json: @beispiel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /beispiele/1
  # PUT /beispiele/1.json
  def update
    @beispiel = Beispiel.find(params[:id])

    respond_to do |format|
      if @beispiel.update_attributes(params[:beispiel])
        format.html { redirect_to @beispiel, notice: 'Beispiel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beispiel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beispiele/1
  # DELETE /beispiele/1.json
  def destroy
    @beispiel = Beispiel.find(params[:id])
    @beispiel.destroy

    respond_to do |format|
      format.html { redirect_to beispiele_url }
      format.json { head :no_content }
    end
  end
end
