require 'test_helper'

class UserinfoControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    post "/register", params: {Email: "validemail1@test.com", password: "validpassword1", passwordcheck: "validpassword1", FirstName: "Bob", SurName: "Nottingham", Company: "UoN", JobTitle: "professor", WorkEmail: "validemail2@test.com", PhoneNum: "01234567890", Question1: "q1", Question2: "q2", Question3: "q3", Answer1: "a1", Answer2: "a2", Answer3: "a3",AvatarID:1}
    assert_response 201, "Failed to create test user in setup"
    post "/authenticate", params: {email: "validemail1@test.com",password: "validpassword1"}
    assert_response 200, "Failed to login into test user"
    @validToken = JSON.parse(response.body)["auth_token"]
  end

  test "get_user_info responds with 200 if a valid email is used" do
    #call the api
    get "/user?email=validemail1@test.com", headers: {"Authorization": @validToken}
	
    # check the response status
    assert_response :success, "Did not get 200 despite using the valid test email"
	
    # check is the response data the same as the data stored in the database
    assert_not response.body.blank? ,"The response was blank"
	result = JSON.parse(@response.body)
	
    assert_equal "Bob", result["firstname"], "firstname key is not the same as database"
    assert_equal "Nottingham", result["surname"], "surname key is not the same as database"
    assert_equal "UoN", result["company"], "company key is not the same as database"
    assert_equal "professor", result["jobtitle"], "jobtitle key is not the same as database"
    assert_equal "validemail2@test.com", result["workemail"], "workemail key is not the same as database"
    assert_equal "01234567890", result["phonenum"], "phonenum key is not the same as database"
    assert_equal 1, result["avatarid"], "AvatarID is not the same as database"
  end
  
  test "get_user_info responds with a 404 if the email provided doesn't exist" do
    #call the api
    get "/user?email=invalidemail@test.com", headers: {"Authorization": @validToken}
	
    #check the response status
    assert_response :missing, "Did not get 404 despite using the missing test email"
  end
  
  test "get_user_info responds with a 400 if the email is missing" do
    #call the api
    get "/user", headers: {"Authorization": @validToken}
	
    #check the response status
    assert_response :bad_request, "Did not get 400 despite using the missing test email"
  end
  
  test "get_user_info responds with a 404 if the format of email is wrong" do
    #empty string
    get "/user?email=", headers: {"Authorization": @validToken}
	result = JSON.parse(@response.body)
    assert_response :missing, "Did not get 404 despite using the email is null"
	
    #blank string
    get "/user?email= ", headers: {"Authorization": @validToken}
    assert_response :missing, "Did not get 404 despite using the email is blank"
	
    #random strings
    get "/user?email=1234543246", headers: {"Authorization": @validToken}
    assert_response :missing, "Did not get 404 despite using the email is in a wrong format"
	
    # get "/user?email=>!@#$%^&*()"
    # assert_response :missing, "Did not get 404 despite using the email is in a wrong format"
  end

  test "get_user_info responds with 401 with no token" do
    get "/user?email=validemail1@test.com"
    assert_response 401, "Did not get a 401 despite not using a token"
  end

  test "get_user_info responds with 401 with an invalid token" do
    get "/user?email=validemail1@test.com", headers:{"Authorization": "hinasd"}
    assert_response 401, "Did not get a 401 despite using an invalid token"
  end

  test "get_user_info_with_token responds with a 401 if no token is used" do
    get "/user/token"
    assert_response 401, "Did not get a 401 despite using no token"
  end
  
  test "get_user_info_with_token responds with a 401 if an invalid token is used" do
    get "/user/token" ,headers: {"Authorization": "asdasdasd"}
    assert_response 401, "Did not get a 401 despite using a random invalid token"
  end

  test "get_user_info_with_token responds with a 200 if a valid token is used" do
    get "/user/token" ,headers: {"Authorization": @validToken}
    assert_response 200, "Did not get a 200 response despite using a valid token"
  end

  test "get_user_info_with_token responds with the user information relating to the user which created the token" do
    get "/user/token" ,headers: {"Authorization": @validToken}
    assert_not response.body.blank? ,"The response was blank"
	  result = JSON.parse(@response.body)
    assert_equal "Bob", result["firstname"], "firstname key is not the same as database"
    assert_equal "Nottingham", result["surname"], "surname key is not the same as database"
    assert_equal "UoN", result["company"], "company key is not the same as database"
    assert_equal "professor", result["jobtitle"], "jobtitle key is not the same as database"
    assert_equal "validemail2@test.com", result["workemail"], "workemail key is not the same as database"
    assert_equal "01234567890", result["phonenum"], "phonenum key is not the same as database"
    assert_equal 1, result["avatarid"], "AvatarID is not the same as database"
  end

end
