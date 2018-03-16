require 'test_helper'

class BillsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get bills_show_url
    assert_response :success
  end

end
