require "test_helper"

class ExamEvaluationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exam_evaluation = exam_evaluations(:one)
  end

  test "should get index" do
    get exam_evaluations_url
    assert_response :success
  end

  test "should get new" do
    get new_exam_evaluation_url
    assert_response :success
  end

  test "should create exam_evaluation" do
    assert_difference("ExamEvaluation.count") do
      post exam_evaluations_url, params: { exam_evaluation: { course_id: @exam_evaluation.course_id, marks: @exam_evaluation.marks, progress_card_id: @exam_evaluation.progress_card_id } }
    end

    assert_redirected_to exam_evaluation_url(ExamEvaluation.last)
  end

  test "should show exam_evaluation" do
    get exam_evaluation_url(@exam_evaluation)
    assert_response :success
  end

  test "should get edit" do
    get edit_exam_evaluation_url(@exam_evaluation)
    assert_response :success
  end

  test "should update exam_evaluation" do
    patch exam_evaluation_url(@exam_evaluation), params: { exam_evaluation: { course_id: @exam_evaluation.course_id, marks: @exam_evaluation.marks, progress_card_id: @exam_evaluation.progress_card_id } }
    assert_redirected_to exam_evaluation_url(@exam_evaluation)
  end

  test "should destroy exam_evaluation" do
    assert_difference("ExamEvaluation.count", -1) do
      delete exam_evaluation_url(@exam_evaluation)
    end

    assert_redirected_to exam_evaluations_url
  end
end
