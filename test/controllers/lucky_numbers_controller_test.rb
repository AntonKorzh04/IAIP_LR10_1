require "test_helper"

class LuckyNumbersControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get lucky_numbers_input_url
    assert_response :success
  end

  test "should get view" do
    get lucky_numbers_view_url
    assert_response :success
  end

  test "should get JSON for view with 2000" do
    # json, получаемый при запросе с параметрами {numbers_count: "2000"}
    expected_json = {"0":"000000","1":"001001","2":"001010","3":"001100"}.to_json
    
    get lucky_numbers_view_url, params: { numbers_count: "2000" }, as: :json
    assert_response :success
    assert_equal expected_json, response.body
  end

  # test for testing xml response
  test "should get XML for view with 2000" do
    # xml, получаемый при запросе с параметрами {numbers_count: "2000"}
    # read from file "test\controllers\xml\xml_code_test.xml" and write its contents to expected_xml
    expected_xml = File.read('test/controllers/xml/xml_code_test.xml')
    get '/lucky_numbers/view.xml', params: { numbers_count: '2000' }
    assert_response :success
    assert_equal expected_xml, response.body
  end
end
