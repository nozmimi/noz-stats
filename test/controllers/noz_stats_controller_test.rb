require 'test_helper'

class NozStatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get noz_stats_index_url
    assert_response :success
  end

end
