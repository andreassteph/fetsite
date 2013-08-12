class SemestersController < ApplicationController

  def index
    @semesters = Semester.all
  end

  
  def show
    @semester = Semester.find(params[:id])

  end

  def new
    @semester = Semester.new
  end

  def edit
    @semester = Semester.find(params[:id])
    @studium = @semester.studium
  end

  def create
    @semester = Semester.new(params[:semester])
    

    respond_to do |format|
      if @semester.save
        format.html { redirect_to @semester, notice: 'Semester was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @semester = Semester.find(params[:id])
    @studium= @semester.studium
    respond_to do |format|
      if @semester.update_attributes(params[:semester])
        format.html { redirect_to @semester, notice: 'Semester was successfully updated.' } 
      else
        format.html { render action: "edit" }     
      end
    end
  end

  def destroy
    @semester = Semester.find(params[:id])
    @semester.destroy
    redirect_to semester_url
    
  end
end
