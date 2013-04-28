 class TakenCoursesController < ApplicationController

   respond_to :html, :js

   def index

    @student = Student.find(params[:student_id])
    @taken_courses = @student.taken_courses

    authorize! :read, @taken_courses

    respond_to do |format|
      format.js
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show

    @taken_course = TakenCourse.find(params[:id])
   
    authorize! :read, @taken_course

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

      authorize! :create, @taken_course

  else

    flash[:error] = "Student id doesn't exist"
   
  end

   respond_to do |format|
      format.js { render :handlers => [:erb] }
     end

  end

  # GET /students/1/edit
  def edit
    @taken_course = TakenCourse.find(params[:id])
    authorize! :read, @taken_course
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
    else 
          logger.debug "********************************************************************************************************************************************************"
          logger.debug "Taken course was not created. Student: #{@taken_course.attributes.inspect}"
    end

    respond_to do |format|
      format.js
   
    end
     
end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @taken_course = TakenCourse.find(params[:id])

    authorize! :read, @taken_courses

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
    @student = current_user
    @taken_course = TakenCourse.find(params[:id])
    @taken_course.destroy

    authorize! :destroy, @taken_course

    respond_to do |format|
      format.html { redirect_to @student }
      format.json { head :no_content }
    end
  end

  

private 

def updateCredits(taken_course)

  @student = current_user

  

  authorize! :read, @taken_course

  if(taken_course.is_major.to_s == "true")

    @student.update_attribute(:major_credits_earned, @student.major_credits_earned.to_i + taken_course.credits)

    logger.debug "Taken course is: "
    logger.debug "#{taken_course.name}"
    logger.debug "#{taken_course.credits}"
  
  end

  @student.update_attribute(:credits_earned, @student.credits_earned.to_i + taken_course.credits)
    
end



def calculateGPA(taken_course)

  @student = current_user
  gradingSchema = { "A" => 4.0, "AB" => 3.5, "B" => 3.0, "BC" => 2.5, "C" =>2.0, "CD" =>1.5, "D"=> 1.0, "F" => 0.0 }

  authorize! :read, @taken_course

  if(taken_course.is_major.to_s == "true")
     @major_course_credits = taken_course.credits
  else
     @major_course_credits = 0
  end


  #for cumulative
  @htps_before = @student.cumulative_gpa.to_f * (@student.credits_earned.to_f -  taken_course.credits.to_f)
  @htps_after = taken_course.credits  * gradingSchema[taken_course.grade.to_s]
  @all_possible_htps = @student.credits_earned * 4

  #for major
  @major_htps_before = @student.major_gpa.to_f * (@student.major_credits_earned.to_f -  @major_course_credits.to_f)
  @major_htps_after = @major_course_credits *  gradingSchema[taken_course.grade.to_s]
  @major_all_possible_htps = @student.major_credits_earned * 4


  @student.update_attribute(:cumulative_gpa, ((@htps_before + @htps_after)/ @all_possible_htps) * 4)
  

  if (taken_course.is_major.to_s == "true" )
      @student.update_attribute(:major_gpa, ((@major_htps_before + @major_htps_after)/ @major_all_possible_htps) * 4)
  end
  
end


end


