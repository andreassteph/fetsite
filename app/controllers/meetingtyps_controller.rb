class MeetingtypsController < ApplicationController
  load_and_authorize_resource
  def index
    @meetingtyps=Meetingtyp.all
  end
  def show
    redirect_to action: :index
  end
  def edit
    @meetingtyp = Meetingtyp.find(params[:id])
  end
  def new
    @meetingtyp=Meetingtyp.new
  end
  def create_protocol_and_agenda
    @meetingtyp = Meetingtyp.find(params[:id])  
    if @meetingtyp.agenda.nil?
      d=Document.new
      d.typ=11
      d.name="Agendavorlage"
      d.save
      @meetingtyp.agenda=d
    end
    if @meetingtyp.protocol.nil?
      d=Document.new
      d.typ=10
      d.name="Protokollvorlage"
      d.save
      @meetingtyp.protocol=d
    end
    redirect_to action: :index
  end


  def create
    @meetingtyp = Meetingtyp.new(params[:meetingtyp])
    @meetingtyp.assign_attributes(params[:meetingtyp])

    respond_to do |format|
      if @meetingtyp.save
       format.html { redirect_to @meetingtyp, notice: 'Meeting was successfully created.' }
        #format.json { render json: @meeting, status: :created, location: @meeting }
        format.js
      else
        format.html { render action: "new" }
   #     format.json { render json: @meeting.errors, status: :unprocessable_entity }
        format.js { render action: "new" }
      end
    end
  end

def update
  @meetingtyp = Meetingtyp.find(params[:id])
    respond_to do |format|
    if @meetingtyp.update_attributes(params[:meetingtyp])
        format.html { redirect_to @meetingtyp, notice: 'Meeting was successfully updated.' }
     #   format.json { head :no_content }
        format.js
      else
        format.html  { render action: "edit" }
    #    format.json { render json: @meeting.errors, status: :unprocessable_entity }
        format.js { render action: "edit" }
      end
    end
  end
  def destroy
    @meetingtyp = Meeting.find(params[:id])
    @meetingtyp.destroy
    respond_to do |format|
      format.html { redirect_to action: :index}
    end
  end



end
