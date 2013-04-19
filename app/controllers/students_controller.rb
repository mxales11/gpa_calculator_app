class StudentsController < ApplicationController
  # GET /students
  # GET /students.json

  respond_to :html, :js

  def index
    @students = Student.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @students }
    end
  end

  # GET /students/1
  # GET /students/1.json
    def show
      @student = Student.find(params[:id])
      @taken_courses =  @student.taken_courses
      logger.debug "Student  #{@student.attributes.inspect}"
      Rails.logger.info("PARAMS: #{params.inspect}")

    #@student.update_attributes(params[:student])
    
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

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end



  def calculateGpaNeededForTargetCumulativeGpa

     @student = current_student
     @gpa_for_target_cumulative_gpa = Projector.calculateGpaNeededForTargetCumulativeGpa(@student, params[:desired_cumulative_gpa], params[:credits_taken_this_semester])
  
     respond_to do |format|
      format.js { render :handlers => [:erb] }
     end
  end
    

  def calculateGpaNeededForTargetMajorGpa

    @student = current_student
    @gpa_for_target_major_gpa = Projector.calculateGpaNeededForTargetMajorGpa(@student, params[:desired_major_gpa], params[:major_credits_taken_this_semester])

     respond_to do |format|
      format.js { render :handlers => [:erb] }
     end
  
  end


   def calculatePredictedGpas

      #use the 2 below methods
  
  end



  def calculatePredictedCumulativeGpa

    @student = current_student
    @predicted_cumulative_gpa = 4.4

     respond_to do |format|
      format.js { render :handlers => [:erb] }
     end
  end
  

  def calculatePredictedMajorGpa

     @student = current_student
     @predicted_major_gpa  = 5.5
     
     respond_to do |format|
      format.js { render :handlers => [:erb] }
     end
  end



  private

  def initializeStudentAttibutes(student)

     student.update_attribute(:major_gpa, 0.0)
     student.update_attribute(:cumulative_gpa, 0.0)
     student.update_attribute(:credits_earned, 0)
     student.update_attribute(:major_credits_earned, 0)
  end

end
