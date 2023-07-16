class ProgressCardsController < ApplicationController
  before_action :set_progress_card, only: %i[ show edit update destroy ]
  before_action :set_student, only: %i[ index new create show edit update destroy enrollment_verdict]
  before_action :set_school, only: %i[ index new create show edit update destroy enrollments request_enrollment]


  # GET /progress_cards or /progress_cards.json
  def index
    @progress_cards = @student.progress_cards
  end

  # GET /progress_cards/1 or /progress_cards/1.json
  def show
  end

  # GET /progress_cards/new
  def new
    @progress_card = ProgressCard.new(student_id: params[:student_id], batch_id: @student.current_batch.id)
    @progress_card.build_score_card(@student)
  end

  # GET /progress_cards/1/edit
  def edit
  end

  # POST /progress_cards or /progress_cards.json
  def create
    @progress_card = ProgressCard.new(progress_card_params)
    @progress_card.student_id = @student.id
    @progress_card.batch_id = @student.current_batch.id

    respond_to do |format|
      if @progress_card.save
        format.html { redirect_to school_student_progress_card_url(@school, @student, @progress_card), notice: "Progress card was successfully created." }
        format.json { render :show, status: :created, location: @progress_card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @progress_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /progress_cards/1 or /progress_cards/1.json
  def update
    respond_to do |format|
      if @progress_card.update(progress_card_params)
        format.html { redirect_to progress_card_url(@progress_card), notice: "Progress card was successfully updated." }
        format.json { render :show, status: :ok, location: @progress_card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @progress_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progress_cards/1 or /progress_cards/1.json
  def destroy
    @progress_card.destroy

    respond_to do |format|
      format.html { redirect_to school_student_progress_cards_url(@school,@student), notice: "Progress card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_progress_card
      @progress_card = ProgressCard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def progress_card_params
      params.require(:progress_card).permit(:exam_name, :declaration, :student_id, :batch_id, exam_evaluations_attributes: [:course_id, :marks])
    end

    def set_student
      @student = Student.find(params[:student_id])
    end

    def set_school
      @school = School.find(params[:school_id])
    end
end
