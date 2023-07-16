require "application_system_test_case"

class ExamEvaluationsTest < ApplicationSystemTestCase
  setup do
    @exam_evaluation = exam_evaluations(:one)
  end

  test "visiting the index" do
    visit exam_evaluations_url
    assert_selector "h1", text: "Exam evaluations"
  end

  test "should create exam evaluation" do
    visit exam_evaluations_url
    click_on "New exam evaluation"

    fill_in "Course", with: @exam_evaluation.course_id
    fill_in "Marks", with: @exam_evaluation.marks
    fill_in "Progress card", with: @exam_evaluation.progress_card_id
    click_on "Create Exam evaluation"

    assert_text "Exam evaluation was successfully created"
    click_on "Back"
  end

  test "should update Exam evaluation" do
    visit exam_evaluation_url(@exam_evaluation)
    click_on "Edit this exam evaluation", match: :first

    fill_in "Course", with: @exam_evaluation.course_id
    fill_in "Marks", with: @exam_evaluation.marks
    fill_in "Progress card", with: @exam_evaluation.progress_card_id
    click_on "Update Exam evaluation"

    assert_text "Exam evaluation was successfully updated"
    click_on "Back"
  end

  test "should destroy Exam evaluation" do
    visit exam_evaluation_url(@exam_evaluation)
    click_on "Destroy this exam evaluation", match: :first

    assert_text "Exam evaluation was successfully destroyed"
  end
end
