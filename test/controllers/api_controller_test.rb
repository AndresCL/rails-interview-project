require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # Test if tenantkey exists
  test "Is tenant key present?" do
    get "/api/questions", params: { tenantkey: '1234'}
    assert_not_empty(@request.params[:tenantkey], 'Tenant Api Key should not be empty')
  end

  # Test if tenantkey belongs to a user
  test "Is tenant key valid?" do
    # Valid API Key: 9a89b343398b2047da6f6b6ecdb7bcab
    get "/api/questions", params: { tenantkey: '123'}
    assert(Tenant.exists?(api_key: @request.params[:tenantkey]), 'Tenant Api Key is not valid')
  end

end
