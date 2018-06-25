require 'test_helper'

class SecurityQuestionsControllerTest < ActionDispatch::IntegrationTest
    setup do
      post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
      assert_response 201, "Failed to create test user in setup"
    end

    test "get security questions responds with 400 if email parameter is missing" do
      get "/securityquestions"
      assert_response 400, "Did not get 400 despite not including email parameter"
    end

    test "get security questions responds with 200 if a valid email is used " do
      get "/securityquestions?email=validemail1@test.com"
      assert_response 200, "Did not get 200 despite using the valid test email"
    end

    test "get security questions responds with a 404 if the email parameter is blank" do
      get "/securityquestions?email="
      assert_response 404, "Did not get 404 despite the email parameter being empty"
    end

    test "get security questions responds with a 404 if the email provided doesn't exist" do
      get "/securityquestions?email=randomemail@gmail.com"
      assert_response 404, "Did not get a 404 despite the email provided not existing"
    end

    test "get security questions returns 3 questions in the request body" do
      get "/securityquestions?email=validemail1@test.com"
      assert_response 200, "Did not get 200 despite using the valid test email"
      assert_not response.body.blank?, "The response body was blank"
      returned = JSON.parse(response.body)
      assert returned.key?("question1"), "question1 key was missing from the body"
      assert returned.key?("question2"), "question2 key was missing from the body"
      assert returned.key?("question3"), "question3 key was missing from the body"
      assert_not returned["question1"].blank?, "question 1 was blank"
      assert_not returned["question2"].blank?, "question 2 was blank"
      assert_not returned["question3"].blank?, "question 3 was blank"
    end

    test "validate security answers responds with 400 if an answer parameter is missing" do
      post "/validateanswers", params: {email:"validemail1@test.com",answer2:"answer2",answer3:"answer3",newpassword:"testpassword1234",passwordcheck:"testpassword1234"}
      assert_response 400, "Did not receieve 400 despite answer 1 parameter missing"
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"answer1",answer3:"answer3",newpassword:"testpassword1234",passwordcheck:"testpassword1234"}
      assert_response 400, "Did not receive 400 despite answer 2 parameter missing"
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"answer1",answer2:"answer2",newpassword:"testpassword1234",passwordcheck:"testpassword1234"}
      assert_response 400, "Did not receive 400 despite answer 3 parameter missing"      
    end

    test "validate security answers responds with 401 if an answer is incorrect" do
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"Wrong Test answer 1",answer2:"Test answer 2",answer3:"Test answer 3",newpassword:"testpassword1234",passwordcheck:"testpassword1234"}
      assert_response 401, "Did not receive 401 despite answer 1 being different to the test answer 1"
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"Test answer 1",answer2:"Wrong Test answer 2",answer3:"Test answer 3",newpassword:"testpassword1234",passwordcheck:"testpassword1234"}
      assert_response 401, "Did not receive 401 despite answer 2 being different to the test answer 2"
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"Test answer 1",answer2:"Test answer 2",answer3:"Wrong Test answer 3",newpassword:"testpassword1234",passwordcheck:"testpassword1234"}
      assert_response 401, "Did not receive 401 despite answer 3 being different to the test answer 3"
    end

    test "validate security answers responds with 400 if the password isn't valid" do
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"Test answer 1",answer2:"Test answer 2",answer3:"Test answer 3",newpassword:"badpassword",passwordcheck:"badpassword"}
      assert_response 400, "Did not get 400 despite the password not being valid"
    end

    test "validate security answers responds with 400 if the newpassword parameter is missing" do
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"Test answer 1",answer2:"Test answer 2",answer3:"Test answer 3",passwordcheck:"testpassword1234"}
      assert_response 400, "Did not get 400 despite the newpassword parameter missing"
    end

    test "validate security answers responds with 400 if the passwordcheck parameter is missing" do
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"Test answer 1",answer2:"Test answer 2",answer3:"Test answer 3",newpassword:"testpassword1234"}
      assert_response 400, "Did not get 400 despite the passwordcheck paramter being missing"
    end

    test "validate security answers responds with 400 if the password and passwordcheck do not match" do
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"Test answer 1",answer2:"Test answer 2",answer3:"Test answer 3",newpassword:"testpassword1234",passwordcheck:"notpassword"}      
      assert_response 400, "Did not get 400 depsite the passwords not matching"
    end

    test "validate security answers responds with 200 if the answers are all correct and the password is valid and match" do
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"Test answer 1",answer2:"Test answer 2",answer3:"Test answer 3",newpassword:"testpassword1234",passwordcheck:"testpassword1234"}
      assert_response 200, "Did not get 200 despite all of the input data being valid"
    end

    test "validate security answers updates the password in the database to the password passed in if the answers are correct" do
      newpass = "testpassword1234"
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"Test answer 1",answer2:"Test answer 2",answer3:"Test answer 3",newpassword:newpass,passwordcheck:newpass}
      assert_response 200, "Failed to validate valid answers against a valid email"
      post "/authenticate", params: {email: "validemail1@test.com",password:newpass}
      assert_response 200, "Failed to login using the new password that had just been updated"
    end

    test "validate security answers responds with 400 if the email parameter is missing" do
      post "/validateanswers", params: {answer1:"Test answer 1",answer2:"Test answer 2",answer3:"Test answer 3",newpassword:"testpassword1234",passwordcheck:"testpassword1234"}      
      assert_response 400, "Did not get 400 despite the email parameter missing"
    end
    
    test "validate security answers responds with 404 if the email does not exist" do
      post "/validateanswers", params: {email:"nottest1email@hexcore.com",answer1:"Test answer 1",answer2:"Test answer 2",answer3:"Test answer 3",newpassword:"testpassword1234",passwordcheck:"testpassword1234"}
      assert_response 404, "Did not get 404 despite the email not matching the test email that's been registered"      
    end

    test "validate security answers responds with 400 if the password is invalid" do
      post "/validateanswers", params: {email:"validemail1@test.com",answer1:"Test answer 1",answer2:"Test answer 2",answer3:"Test answer 3",newpassword:"testtssts",passwordcheck:"testpassword1234"}
      assert_response 400, "Did not get 400 despite an invalid password being used"
    end
end
