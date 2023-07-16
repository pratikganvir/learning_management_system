class StudentsController < ApplicationController
  include SetContext
  before_action :set_student, only: %i[ show edit update destroy enrollments request_enrollment classmates]
  before_action :set_school, only: %i[ index new create show edit update destroy enrollments request_enrollment classmates]

  # GET /students or /students.json
  def index
    @students = @school.students
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
    @student.build_login
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)
    @student.school_id = @school.id

    respond_to do |format|
      if @student.save
        format.html { redirect_to school_student_url(@school, @student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to school_student_url(@school, @student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to school_students_url(@school), notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def enrollments
    @batches = @school.batches.includes(:enrollments)
  end

  def request_enrollment
    @enrollment_request = @student.enrollments.new({batch_id: enrollment_params[:batch_id], status: Enrollment.statuses[:requested]})

    respond_to do |format|
      if @enrollment_request.save
        format.html { redirect_to enrollments_school_student_path(@school, @student), notice: "Enrollment request succesfully created" }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { redirect_to enrollments_school_student_path(@school, @student), notice: @enrollment_request.errors.full_messages.join }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def classmates
    @classmates = @student.classmates
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :middle_name, :last_name, :date_of_birth, :gender, login_attributes: [:email, :password, :password_confirmation])
    end

    def enrollment_params
      params.permit(:batch_id, :school_id, :student_id)
    end
end
