require "test_helper"

class Admin::UsuariosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_usuarios_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_usuarios_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_usuarios_edit_url
    assert_response :success
  end

  test "should get show" do
    get admin_usuarios_show_url
    assert_response :success
  end
end
