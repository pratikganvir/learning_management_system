class EnrollmentsController < ApplicationController
  include SetContext
  before_action :set_enrollment, only: %i[ show edit update destroy enrollment_verdict]
  before_action :set_school, only: %i[ index new create show edit update destroy enrollment_verdict]
  before_action :set_batch, only: %i[ index enrollment_verdict]

  # GET /enrollments or /enrollments.json
  def index
    @enrollments = Enrollment.all
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments or /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to school_batch_enrollment_path(@school, @batch, @enrollment), notice: "Enrollment was successfully created." }
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to school_batch_enrollment_path(@school, @batch, @enrollment), notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    @enrollment.destroy

    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: "Enrollment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def enrollment_verdict
    @enrollment.status = enrollment_verdict_params[:enrollment_action]

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to school_batch_enrollments_path(@school, @batch), notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { redirect_to school_batch_enrollments_path(@school, @batch), notice: @enrollment.errors.full_messages.join }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:student_id, :batch_id, :status)
    end

    def enrollment_verdict_params
      params.permit(:enrollment_action)
    end
end
