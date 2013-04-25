class StudentsController < ApplicationController
  # GET /students
  # GET /students.json

  respond_to :html, :js

  def index
    @students = Student.all
    authorize! :read, @students

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @students }
    end
  end

  # GET /students/1
  # GET /students/1.json
    def show
      @student = Student.find(params[:id])
      @taken_courses = @student.taken_courses
      logger.debug "Student #{@student.attributes.inspect}"
      Rails.logger.info("PARAMS: #{params.inspect}")

      authorize! :read, @student

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @student }
      end
    end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
    authorize! :update, @student
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(params[:student])
    
    if @student.save
      sign_in @student
      flash[:success] = "Welcome to Make Projections App!"
      initializeStudentAttibutes(@student)
      redirect_to @student

    else
      render 'new'
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @student = Student.find(params[:id])

    authorize! :update, @student
    
    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    authorize! :destroy, @student

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end



  def calculateGpaNeededForTargetCumulativeGpa

     @student = current_user
     @gpa_for_target_cumulative_gpa = Projector.calculateGpaNeededForTargetCumulativeGpa(@student, params[:desired_cumulative_gpa], params[:credits_taken_this_semester])
  
     authorize! :read, @student
     respond_to do |format|
      format.js { render :handlers => [:erb] }
     end
  end
    

  def calculateGpaNeededForTargetMajorGpa

    @student = current_user
    @gpa_for_target_major_gpa = Projector.calculateGpaNeededForTargetMajorGpa(@student, params[:desired_major_gpa], params[:major_credits_taken_this_semester])

    authorize! :read, @student

     respond_to do |format|
      format.js { render :handlers => [:erb] }
     end
  
  end


   def calculatePredictedGpas

     @student = current_user

    authorize! :read, @student
     #get rid of that and just use an array in a form
     @credits_array = getArrayOfParams("credits", 7)
     @predicted_grade_array = getArrayOfParams("predicted_grade", 7)
     @is_repeated_course_array = getArrayOfParams("is_repeated_course", 7);
     @is_major_course_array =  getArrayOfParams("is_major_course", 7);


     Rails.logger.info("Credits array: #{@credits_array}")
     Rails.logger.info("Predicted grade array: #{@predicted_grade_array}")
     Rails.logger.info("is Repeated course array: #{@is_repeated_course_array}")
     Rails.logger.info("is major course array: #{@is_major_course_array}")



     @predicted_cumulative_gpa = Projector.calculatePredictedCumulativeGpa(@student, @credits_array, @predicted_grade_array, @is_repeated_course_array)
     @predicted_major_gpa = Projector.calculatePredictedMajorGpa(@student, @credits_array, @predicted_grade_array, @is_major_course_array, @is_repeated_course_array)

       #change it so it returns both not one
      @predicted_gpas = Array.new
      @predicted_gpas.push(@predicted_cumulative_gpa)
      @predicted_gpas.push(@predicted_major_gpa)

     respond_to do |format|
      format.js { render :handlers => [:erb] }
     end
    
  end

  def getArrayOfParams(parameter, arrayLength)

    arrayOfParams = Array.new
    length = arrayLength.to_i
    
    length.to_i.times do |i|
        arrayOfParams.push(params[:"#{parameter}#{i.to_s}"])
      end

    return arrayOfParams
  end


  private

  def initializeStudentAttibutes(student)

     student.update_attribute(:major_gpa, 0.0)
     student.update_attribute(:cumulative_gpa, 0.0)
     student.update_attribute(:credits_earned, 0)
     student.update_attribute(:major_credits_earned, 0)
   
  end

end