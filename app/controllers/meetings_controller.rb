class MeetingsController < ApplicationController

  load_and_authorize_resource
  def index
    parent=params[:parent_type].constantize.find(params[:parent_id])
    unless parent.nil?
      #authorize! :show, parent
      if params[:filter]=="upcomming"
        @meetings=parent.meetings.includes(:calentry).where("calentries.start>?",1.hour.ago)
      else
      @meetings=parent.meetings
      end
      @parent=parent
    end
    respond_to do |format|
      format.html {redirect_to rubriken_path}
      format.js
    end
  end
  def announce
    m=Meeting.find(params[:id])
    m.create_announcement(current_user)
    m.save
   
    respond_to do |format|
      format.html {redirect_to m.parent}
      format.js {render action: :show}  
    end
  end
  def show
    m=Meeting.find(params[:id])
    respond_to do |format|
      format.html {redirect_to m.parent}
      format.js  
      
    end
end
  def new
    @meeting=Meeting.new
    @meeting.parent=params[:parent_type].constantize.find(params[:parent_id])
    @parent=@meeting.parent
    @meeting.calentry=Calentry.new
    @meeting.calentry.typ = 2
    respond_to do |format|
      format.js
    end
  end
  def create_protocol
    @meeting = Meeting.find(params[:id])
    @meeting.create_protocol
    @meeting.save
    respond_to do |format|
      format.js {render action: :show}
    end
  end
  def create_agenda
    @meeting = Meeting.find(params[:id])
    @meeting.create_agenda
  
  
    respond_to do |format|
      format.js {render action: :show}
    end
  end
  def edit
    @meeting = Meeting.find(params[:id])

@parent=@meeting.parent    
respond_to do |format|
       format.js
    end

  end

  def create
    @meeting = Meeting.new(params[:meeting])

    @parent=@meeting.parent
    #@meeting.assign_attributes(params[:meeting])

    respond_to do |format|
      if @meeting.save
       # format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        #format.json { render json: @meeting, status: :created, location: @meeting }
        format.js
      else
    #    format.html { render action: "new" }
   #     format.json { render json: @meeting.errors, status: :unprocessable_entity }
        format.js { render action: "new" }
      end
    end
  end

def update

  @meeting = Meeting.find(params[:id])
  @parent=@meeting.parent
    respond_to do |format|
    if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { head :no_content }
        format.js
      else

     #   format.html 
    #    format.json { render json: @meeting.errors, status: :unprocessable_entity }
        format.js { render action: "edit" }
      end
    end
  end
  def destroy
    logger.info("-------------delete------------------")
    @meeting = Meeting.find(params[:id])

    @parent=@meeting.parent
    @meeting_id = params[:id]  
    @meeting.destroy
    
    respond_to do |format|
      #format.html { redirect_to @object}
      #format.json { head :no_content }
      format.js 
    end
  end




end
