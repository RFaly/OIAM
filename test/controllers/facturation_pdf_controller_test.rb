require 'test_helper'

class FacturationPdfControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get facturation_pdf_index_url
    assert_response :success
  end

end
