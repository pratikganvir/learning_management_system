require "application_system_test_case"

class ProgressCardsTest < ApplicationSystemTestCase
  setup do
    @progress_card = progress_cards(:one)
  end

  test "visiting the index" do
    visit progress_cards_url
    assert_selector "h1", text: "Progress cards"
  end

  test "should create progress card" do
    visit progress_cards_url
    click_on "New progress card"

    fill_in "Batch", with: @progress_card.batch_id
    fill_in "Declaration", with: @progress_card.declaration
    fill_in "Exam name", with: @progress_card.exam_name
    fill_in "Student", with: @progress_card.student_id
    click_on "Create Progress card"

    assert_text "Progress card was successfully created"
    click_on "Back"
  end

  test "should update Progress card" do
    visit progress_card_url(@progress_card)
    click_on "Edit this progress card", match: :first

    fill_in "Batch", with: @progress_card.batch_id
    fill_in "Declaration", with: @progress_card.declaration
    fill_in "Exam name", with: @progress_card.exam_name
    fill_in "Student", with: @progress_card.student_id
    click_on "Update Progress card"

    assert_text "Progress card was successfully updated"
    click_on "Back"
  end

  test "should destroy Progress card" do
    visit progress_card_url(@progress_card)
    click_on "Destroy this progress card", match: :first

    assert_text "Progress card was successfully destroyed"
  end
end
