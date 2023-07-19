class CoursesController < ApplicationController
  include SetContext
  before_action :set_course, only: %i[ show edit update destroy ]
  before_action :set_school, only: %i[ index new create show edit update destroy]
  before_action :set_batch, only: %i[ index ]

  # GET /courses or /courses.json
  def index
    #Admin user can see all the courses. If Batch id is passed then courses for the specific bath has to be shown
    @courses = if params[:batch_id]
     Course.joins(:batches_courses).where('batches_courses.batch_id' => params[:batch_id])
    else
      Course.where(school_id: @school.id)
    end
    authorize @courses
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
    authorize @course
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    @course.school_id = @school.id

    respond_to do |format|
      if @course.save
        format.html { redirect_to school_course_url(@school,@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to school_course_url(@schoo, @course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to school_courses_url(@school), notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
      authorize @course
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :description, :school_id)
    end
end
