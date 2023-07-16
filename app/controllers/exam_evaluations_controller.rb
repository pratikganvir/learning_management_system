class ExamEvaluationsController < ApplicationController
  before_action :set_exam_evaluation, only: %i[ show edit update destroy ]

  # GET /exam_evaluations or /exam_evaluations.json
  def index
    @exam_evaluations = ExamEvaluation.all
  end

  # GET /exam_evaluations/1 or /exam_evaluations/1.json
  def show
  end

  # GET /exam_evaluations/new
  def new
    @exam_evaluation = ExamEvaluation.new
  end

  # GET /exam_evaluations/1/edit
  def edit
  end

  # POST /exam_evaluations or /exam_evaluations.json
  def create
    @exam_evaluation = ExamEvaluation.new(exam_evaluation_params)

    respond_to do |format|
      if @exam_evaluation.save
        format.html { redirect_to exam_evaluation_url(@exam_evaluation), notice: "Exam evaluation was successfully created." }
        format.json { render :show, status: :created, location: @exam_evaluation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exam_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exam_evaluations/1 or /exam_evaluations/1.json
  def update
    respond_to do |format|
      if @exam_evaluation.update(exam_evaluation_params)
        format.html { redirect_to exam_evaluation_url(@exam_evaluation), notice: "Exam evaluation was successfully updated." }
        format.json { render :show, status: :ok, location: @exam_evaluation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exam_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exam_evaluations/1 or /exam_evaluations/1.json
  def destroy
    @exam_evaluation.destroy

    respond_to do |format|
      format.html { redirect_to exam_evaluations_url, notice: "Exam evaluation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam_evaluation
      @exam_evaluation = ExamEvaluation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exam_evaluation_params
      params.require(:exam_evaluation).permit(:course_id, :marks, :progress_card_id)
    end
end
