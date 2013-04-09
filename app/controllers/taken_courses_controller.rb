 class TakenCoursesController < ApplicationController

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

    updateCredits(@taken_course, @student)
    calculateGPA(@taken_course, @student)

    logger.debug "********************************************************************************************************************************************************"
    logger.debug "Student  #{@student.attributes.inspect}"
   

    if @taken_course.save!
        logger.debug "********************************************************************************************************************************************************"
        logger.debug "#{@student.attributes.inspect}"
        redirect_to student_taken_courses_path(@student)
    else 
          logger.debug "********************************************************************************************************************************************************"
          logger.debug "Student was not created. Student: #{@student.attributes.inspect}"
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

def updateCredits(taken_course, student)

  @course = Course.find(taken_course.course_id)

  if(taken_course.is_major?)

    student.update_attribute(:major_credits_earned, student.major_credits_earned + @course.credits)

    logger.debug "Course is: "
    logger.debug "#{@course.name}"
    logger.debug "#{@course.credits}"
  
  end

   student.update_attribute(:credits_earned, student.credits_earned + @course.credits)
    
end



def calculateGPA(taken_course, student)

  logger.debug "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  logger.debug "Calculate GPA was invoked"

  @course = Course.find(taken_course.course_id)
  @course_credits = @course.credits

  if(taken_course.is_major?)
     @major_course_credits = @course_credits
  else
     @major_course_credits = 0
  end



  #for cumulative
  @htps_before = student.cumulative_gpa * (student.credits_earned -  @course_credits)
  @htps_after = @course_credits * matchGradeToNumbers(taken_course)
  @all_possible_htps = student.credits_earned * 4

  #for major
  @major_htps_before = student.major_gpa * (student.major_credits_earned -  @major_course_credits)
  @major_htps_after = @major_course_credits *  matchGradeToNumbers(taken_course)
  @major_all_possible_htps = student.major_credits_earned * 4

  #for major

  student.update_attribute(:cumulative_gpa, ((@htps_before + @htps_after)/ @all_possible_htps) * 4)

  if (taken_course.is_major?)
    student.update_attribute(:major_gpa, ((@major_htps_before + @major_htps_after)/ @major_all_possible_htps) * 4)
  end
  
end


def matchGradeToNumbers(taken_course)

  if(taken_course.grade =="A")
    return 4
  elseif (taken_course.grade =="AB")
    return 3.5
  elseif (taken_course.grade =="B")
    return 3
  elseif (taken_course.grade =="BC")
    return 2.5
  elseif (taken_course.grade=="C")
    return 2
  elseif (taken_course.grade =="CD")
    return 1.5
  elseif (taken_course.grade =="D")
    return 1
  elseif (taken_course.grade =="F")
    return 0
  end
end

end


