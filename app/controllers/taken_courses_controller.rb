 class TakenCoursesController < ApplicationController

  autocomplete :course, :name

   def index
    #if  params[:student_id].nil?
      #@taken_courses = TakenCourse.all
    @student = Student.find(params[:student_id])
    @taken_courses = @student.taken_courses
   
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

    if !params[:student_id].nil?

      flash[:success] = "Student id is #{:student_id}"
      @student = Student.find(params[:student_id])
      @taken_course = @student.taken_courses.build
  
  else
    #change it so that it's not a success
    flash[:success] = "Student id doesn't exist"
   
  end

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

    @student = Student.find(params[:student_id])
    @taken_course = @student.taken_courses.build(params[:taken_course])
   

    logger.debug "********************************************************************************************************************************************************"
    logger.debug "Student  #{@student.attributes.inspect}"

    updateCredits(@taken_course)
    calculateGPA(@taken_course)

    logger.debug "********************************************************************************************************************************************************"
    logger.debug "Student  #{@student.attributes.inspect}"
   

    if @taken_course.save!
        logger.debug "********************************************************************************************************************************************************"
        logger.debug "#{@student.attributes.inspect}"
        redirect_to @student
    else 
          logger.debug "********************************************************************************************************************************************************"
          logger.debug "Taken course was not created. Student: #{@taken_course.attributes.inspect}"
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

  

private 

def updateCredits(taken_course)

  @student = current_student
  @course = Course.find(taken_course.course_id)

  if(taken_course.is_major.to_s == "true")

    @student.update_attribute(:major_credits_earned, @student.major_credits_earned + @course.credits)

    logger.debug "Course is: "
    logger.debug "#{@course.name}"
    logger.debug "#{@course.credits}"
  
  end

   @student.update_attribute(:credits_earned, @student.credits_earned + @course.credits)
    
end



def calculateGPA(taken_course)

  @student = current_student
  @course = Course.find(taken_course.course_id)
  gradingSchema = { "A" => 4.0, "AB" => 3.5, "B" => 3.0, "BC" => 2.5, "C" =>2.0, "CD" =>1.5, "D"=> 1.0, "F" => 0.0 }

   logger.debug "calculateGPA was invoked: "
   logger.debug "#{@student.email}"
   logger.debug "Course is: "
   logger.debug "#{@course.name}"
   logger.debug "#{@taken_course.is_major.to_s}"
   logger.debug "#{taken_course.is_major.to_s == "true"}"


  if(taken_course.is_major.to_s == "true")
    logger.debug "We are here"
     @major_course_credits = @course.credits
  else
     @major_course_credits = 0
  end


  #for cumulative
  @htps_before = @student.cumulative_gpa * (@student.credits_earned -  @course.credits)
  @htps_after = @course.credits  * gradingSchema[taken_course.grade.to_s]
  @all_possible_htps = @student.credits_earned * 4

  #for major
  @major_htps_before = @student.major_gpa * (@student.major_credits_earned -  @major_course_credits)
  @major_htps_after = @major_course_credits *  gradingSchema[taken_course.grade.to_s]
  @major_all_possible_htps = @student.major_credits_earned * 4


  @student.update_attribute(:cumulative_gpa, ((@htps_before + @htps_after)/ @all_possible_htps) * 4)
  

  if (taken_course.is_major.to_s == "true" )
      logger.debug "We are here"
      @student.update_attribute(:major_gpa, ((@major_htps_before + @major_htps_after)/ @major_all_possible_htps) * 4)
  end
  
end


end


