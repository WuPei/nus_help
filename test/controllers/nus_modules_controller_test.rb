require 'test_helper'

class NusModulesControllerTest < ActionController::TestCase
  test "should get module_all" do
    get :module_all
    assert_response :success
  end

end
