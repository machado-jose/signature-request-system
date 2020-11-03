require 'test_helper'

class SolicitationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @solicitation = solicitations(:one)
  end

  test "should get index" do
    get solicitations_url
    assert_response :success
  end

  test "should get new" do
    get new_solicitation_url
    assert_response :success
  end

  test "should create solicitation" do
    assert_difference('Solicitation.count') do
      post solicitations_url, params: { solicitation: { description: @solicitation.description, document_id: @solicitation.document_id, user_id: @solicitation.user_id } }
    end

    assert_redirected_to solicitation_url(Solicitation.last)
  end

  test "should show solicitation" do
    get solicitation_url(@solicitation)
    assert_response :success
  end

  test "should get edit" do
    get edit_solicitation_url(@solicitation)
    assert_response :success
  end

  test "should update solicitation" do
    patch solicitation_url(@solicitation), params: { solicitation: { description: @solicitation.description, document_id: @solicitation.document_id, user_id: @solicitation.user_id } }
    assert_redirected_to solicitation_url(@solicitation)
  end

  test "should destroy solicitation" do
    assert_difference('Solicitation.count', -1) do
      delete solicitation_url(@solicitation)
    end

    assert_redirected_to solicitations_url
  end
end
