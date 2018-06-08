require 'test_helper'

class Api::BinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_bin = api_bins(:one)
  end

  test "should get index" do
    get api_bins_url
    assert_response :success
  end

  test "should get new" do
    get new_api_bin_url
    assert_response :success
  end

  test "should create api_bin" do
    assert_difference('Api::Bin.count') do
      post api_bins_url, params: { api_bin: {  } }
    end

    assert_redirected_to api_bin_url(Api::Bin.last)
  end

  test "should show api_bin" do
    get api_bin_url(@api_bin)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_bin_url(@api_bin)
    assert_response :success
  end

  test "should update api_bin" do
    patch api_bin_url(@api_bin), params: { api_bin: {  } }
    assert_redirected_to api_bin_url(@api_bin)
  end

  test "should destroy api_bin" do
    assert_difference('Api::Bin.count', -1) do
      delete api_bin_url(@api_bin)
    end

    assert_redirected_to api_bins_url
  end
end
