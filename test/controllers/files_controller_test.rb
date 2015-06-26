require 'test_helper'

class FilesControllerTest < ActionController::TestCase
  setup :set_access_token

  def set_access_token
    @request.headers['Access-Token'] = users(:brit).access_token
  end

  test "must be logged in to create a file" do
    @request.headers['Access-Token'] = nil

    post :create, folder_id: curations(:brits_music).id,
      upload: fixture_file_upload("files/cookies.jpg")

    assert_response(401)
  end

  test "should be able to upload a file" do
    assert_difference('Contraband.count') do
      cookies = fixture_file_upload("files/cookies.jpg")
      post :create, folder_id: curations(:brits_music).id,
        upload: cookies
    end
  end
end
