require "test_helper"

class StorefrontControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get storefront_index_url
    assert_response :success
  end

  test "should get show" do
    get storefront_show_url
    assert_response :success
  end
end
