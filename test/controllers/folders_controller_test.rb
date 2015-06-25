require 'test_helper'

class FoldersControllerTest < ActionController::TestCase
  setup :set_access_token

  def set_access_token
    @request.headers['Access-Token'] = users(:brit).access_token
  end

  test "creating a folder should give a user a folder" do
    # Checking 3 things:
    # 1) The folder count changes
    # 2) The status code returned is created
    # 3) The instance variable @folder isn't empty.

    assert_difference('Curation.count') do
      post :create, name: 'example', user_id: users(:brit).id
    end

    assert_response(:created)
    assert_not_nil(assigns(:folder))
  end
end
