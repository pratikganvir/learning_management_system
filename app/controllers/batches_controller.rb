class BatchesController < ApplicationController
  include SetContext
  before_action :set_batch, only: %i[ show edit update destroy add_courses create_courses]
  before_action :set_school, only: %i[ index new create show edit update destroy add_courses create_courses]

  # GET /batches or /batches.json
  def index
    @batches = Batch.where(school_id: @school.id)
    authorize @batches
  end

  # GET /batches/1 or /batches/1.json
  def show
  end

  # GET /batches/new
  def new
    @batch = Batch.new
  end

  # GET /batches/1/edit
  def edit
  end

  # POST /batches or /batches.json
  def create
    @batch = Batch.new(batch_params)
    @batch.school_id = @school.id

    respond_to do |format|
      if @batch.save
        format.html { redirect_to school_batch_url(@school,@batch), notice: "Batch was successfully created." }
        format.json { render :show, status: :created, location: @batch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /batches/1 or /batches/1.json
  def update
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to batch_url(@batch), notice: "Batch was successfully updated." }
        format.json { render :show, status: :ok, location: @batch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1 or /batches/1.json
  def destroy
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to school_batches_url(@school), notice: "Batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_courses
    @courses =  @school.courses
  end

  def create_courses
    respond_to do |format|
      if  @batches_courses = @batch.assign_courses(batches_courses_params[:course_id])
        format.html { redirect_to school_courses_url(school_id: @school.id,batch_id: @batch.id), notice: "Courses assigned successfully." }
        format.json { render :show, status: :ok, location: @batch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_batch
      @batch = Batch.find(params[:id])
      authorize @batch
    end

    def batch_params
      params.require(:batch).permit(:name, :start_date, :end_date, :status)
    end

    def batches_courses_params
      params.require(:batch).permit(course_id: [])
    end
end
