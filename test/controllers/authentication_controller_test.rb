require 'test_helper'
require 'digest'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do
    user = User.new(Email: 'validemail1@test.com',password: 'validpassword1')
    user.save
    user = User.new(Email: 'validemail2@test.com',password: 'validpassword2')
    user.save
  end

  test "should return unauthorized if called with no parameters" do
    post "/authenticate", params: {}
    assert_response :unauthorized
  end

  test "should return unauthorized if called without an email address parameter" do
    post "/authenticate", params: {password: "password123"}
    assert_response :unauthorized
  end

  test "should return unauthorized if called with an empty email address" do
    post "/authenticate", params: {email: "", password: "password123"}
    assert_response :unauthorized
    post "/authenticate", params: {email: " ", password: "password123"}
    assert_response :unauthorized
  end

  test "should return unauthorized if called without a password parameter" do
    post "/authenticate", params: {email: "person@test.com"}
    assert_response :unauthorized
  end

  test "should return unauthorized if called with an empty password" do
    post "/authenticate", params: {email: "person@test.com",password:""}
    assert_response :unauthorized
    post "/authenticate", params: {email: "person@test.com",password:" "}
    assert_response :unauthorized
  end

  test "should return unauthorized if an invalid password is used with a valid email address" do
    post "/authenticate", params: {email: "validemail1@test.com",password:"invalidpassword"}
    assert_response :unauthorized
  end
    
  test "should return unauthorized if an invalid email address is used with a valid password" do
    post "/authenticate", params: {email: "invalidemail@test.com",password:"validpassword1"}
    assert_response :unauthorized
  end
    
  test "should return unauthorized if an invalid combination of a valid email address and valid password are used" do
    post "/authenticate", params: {email: "validemail1@test.com",password:"validpassword2"}
    assert_response :unauthorized
  end

  test "should return unauthorized if an invalid email address and invalid password are used" do
    post "/authenticate", params: {email: "invalidemail@test.com",password:"invalidpassword"}
    assert_response :unauthorized
  end
  
  test "should return a new valid token when valid email address and password are used" do
    post "/authenticate", params: {email: "validemail1@test.com",password:'validpassword1'}
    assert_response :success
    assert_not response.body.blank? ,"The response was blank"
    
    returned = JSON.parse(response.body)
    assert returned.key?("auth_token"), "The response didn't contain a token after a successful request"
  end

  test "isvalid should return 200 if valid token used" do
    post "/authenticate", params: {email: "validemail1@test.com",password:'validpassword1'}
    returned = JSON.parse(response.body)
    token = returned["auth_token"]
    post "/isvalid", headers: {"Authorization": token}
    assert_response 200, "Did not get a 200 despite using a valid token on isvalid"
  end

  test "isvalid should return 401 if invalid token is used" do
    post '/isvalid', headers: {"Authorization": "asdfmfakwsdnasdk"}
    assert_response 401, "Did not get a 401 despite using an invalid token on isvalid"
  end

  test "isvalid should return 401 if no token is used" do
    post '/isvalid'
    assert_response 401, "Did not get a 401 despite using no token"
  end

end
