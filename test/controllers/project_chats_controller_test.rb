require 'test_helper'

class ProjectChatsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get project_chats_new_url
    assert_response :success
  end

  test "should get create" do
    get project_chats_create_url
    assert_response :success
  end

end
