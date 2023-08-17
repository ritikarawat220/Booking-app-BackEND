require "test_helper"

class AeroplanesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get aeroplanes_index_url
    assert_response :success
  end

  test "should get show" do
    get aeroplanes_show_url
    assert_response :success
  end

  test "should get new" do
    get aeroplanes_new_url
    assert_response :success
  end

  test "should get create" do
    get aeroplanes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get aeroplanes_destroy_url
    assert_response :success
  end
end
