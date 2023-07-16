require "test_helper"

class ProgressCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @progress_card = progress_cards(:one)
  end

  test "should get index" do
    get progress_cards_url
    assert_response :success
  end

  test "should get new" do
    get new_progress_card_url
    assert_response :success
  end

  test "should create progress_card" do
    assert_difference("ProgressCard.count") do
      post progress_cards_url, params: { progress_card: { batch_id: @progress_card.batch_id, declaration: @progress_card.declaration, exam_name: @progress_card.exam_name, student_id: @progress_card.student_id } }
    end

    assert_redirected_to progress_card_url(ProgressCard.last)
  end

  test "should show progress_card" do
    get progress_card_url(@progress_card)
    assert_response :success
  end

  test "should get edit" do
    get edit_progress_card_url(@progress_card)
    assert_response :success
  end

  test "should update progress_card" do
    patch progress_card_url(@progress_card), params: { progress_card: { batch_id: @progress_card.batch_id, declaration: @progress_card.declaration, exam_name: @progress_card.exam_name, student_id: @progress_card.student_id } }
    assert_redirected_to progress_card_url(@progress_card)
  end

  test "should destroy progress_card" do
    assert_difference("ProgressCard.count", -1) do
      delete progress_card_url(@progress_card)
    end

    assert_redirected_to progress_cards_url
  end
end
