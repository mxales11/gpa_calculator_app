 class TakenCoursesController < ApplicationController

   def index
    if  params[:student_id].nil?
      @taken_courses = TakenCourse.all
    else
      @taken_courses = TakenCourse.find_all_by_student_id(params[:student_id])
    
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @taken_courses }
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @taken_course = TakenCourse.find(params[:id])
    @course = Course.find(@taken_course.course_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @taken_courses }
    end
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @taken_course = TakenCourse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @taken_course }
    end
  end

  # GET /students/1/edit
  def edit
    @taken_course = TakenCourse.find(params[:id])
  end

  # POST /students
  # POST /students.json
  def create
        @taken_course = TakenCourse.new(params[:taken_course])
        @student = Student.find(@taken_course.student_id)
    if @taken_course.save
      flash[:success] = "Taken course was created"
      redirect_to student_taken_courses_path(@student)

      #redirect to student profile where:
      #he can enter his courses to have his cumulative gpa counted
      #he can make projections
    else
      render 'new'
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @taken_course = TakenCourse.find(params[:id])

    respond_to do |format|
      if @taken_course.update_attributes(params[:taken_course])
        format.html { redirect_to @student, notice: 'Taken course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @taken_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @taken_course = TakenCourse.find(params[:id])
    @taken_course.destroy

    respond_to do |format|
      format.html { redirect_to taken_courses_url }
      format.json { head :no_content }
    end
  end

  
end
