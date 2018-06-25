require "test_helper"

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  # Valid Test Data:
  # post "/register", params: {Email: "validemail1@test.com",  #password: "validpassword1",  #passwordcheck: "validpassword1",  #FirstName: "Bob",  #SurName: "Day",  #Company: "hexcore",  #JobTitle: "marketing director",  #WorkEmail: "bob@hexcore.com",  #PhoneNum: "01234567891",  #Question1:"Test question 1",  #Question2:"Test question 2",  #Question3:"Test question 3",  #Answer1:"Test answer 1",  #Answer2:"Test answer 2",  #Answer3:"Test answer 3",AvatarID:1}
  
  test "created response from valid required parameters" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 201, "did not get 201 response despite using valid required parameters"
  end

  test "created response from valid required and optional parameters" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  WorkEmail: "bob@hexcore.com",  PhoneNum: "01234567891",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 201, "did not get 201 response despite using valid required and optional parameters"
  end

  test "created response from valid required parameters with valid WorkEmail" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  WorkEmail: "bob@hexcore.com",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 201, "did not get 201 response despite using valid required parameters and WorkEmail"
  end

  test "created response from valid required parameters with valid PhoneNum" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  PhoneNum: "01234567891",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 201, "did not get 201 response despite using valid required parameters and PhoneNum"
  end

  test "bad request response from invalid email" do
    post "/register", params: {Email: "valid@email1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid email"
    post "/register", params: {Email: "",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank email"
    post "/register", params: {Email: " ",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank email"
  end

  test "bad request response from invalid password" do
    post "/register", params: {Email: "validemail1@test.com",  password: "invalid",  passwordcheck: "invalid",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid password"
    post "/register", params: {Email: "validemail1@test.com",  password: "",  passwordcheck: "",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank password"
    post "/register", params: {Email: "validemail1@test.com",  password: " ",  passwordcheck: " ",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank password"
  end

  test "bad request response from passwordcheck not matching password" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "valid",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite password and password_check not matching"
  end

  test "bad request response from invalid first name" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "ThisAVeryLongNameBecause",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid first name"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank first name"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: " ",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank first name"
  end

  test "bad request response from invalid SurName" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "ThisIsAVeryLongSurnameBecauseItIsAndItIsATest",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid SurName"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank SurName"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: " ",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank SurName"
  end

  test "bad request response from invalid Company too long" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "ThisIsAVeryLongCompanyNameRepeatedThisIsAVeryLongCompanyNameRepeatedThisIsAVeryLongCompanyNameRepeatedThisIsAVeryLongCompanyNameRepeated",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid Company"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Company"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: " ",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Company"
  end

  test "bad request response from invalid JobTitle too long" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "ThisJobTitleIsTooLongRepeatedThisJobTitleIsTooLongRepeatedThisJobTitleIsTooLongRepeated",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid JobTitle"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank JobTitle"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: " ",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank JobTitle"
  end

  test "bad request response from invalid WorkEmail" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  WorkEmail: "bob@hexcore@APlace.com",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid WorkEmail"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  WorkEmail: "",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank WorkEmail"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  WorkEmail: " ",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank WorkEmail"
  end

  test "bad request response from invalid PhoneNum" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  PhoneNum: "012345678911234556",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid PhoneNum"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  PhoneNum: "",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 201 response despite having a blank PhoneNum"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  PhoneNum: " ",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 201 response despite having a blank PhoneNum"
  end

  test "bad request response from invalid Answer1 too long" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"This Is A Very Long Test Security Question Answer That is Definitely Too Long",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid Answer1"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Answer1"
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:" ",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Answer1"
  end

  test "bad request response from invalid Answer2 too long" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"This Is A Very Long Test Security Question Answer That is Definitely Too Long",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid Answer2"
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Answer2"
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:" ",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Answer2"
  end

  test "bad request response from invalid Answer3 too long" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"This Is A Very Long Test Security Question Answer That is Definitely Too Long",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid Answer3"
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Answer3"
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:" ",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Answer3"
  end

  test "bad request response from invalid Question1 too long" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"This Is a Very Long Test Question That is Going to Be greater than 50 characters so it is invalid",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid Question1"
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Question1"
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:" ",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Question1"
  end

  test "bad request response from invalid Question2 too long" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"This Is a Very Long Test Question That is Going to Be greater than 50 characters so it is invalid",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid Question2"
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Question2"
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:" ",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Question2"
  end

  test "bad request response from invalid Question3 too long" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:"This Is a Very Long Test Question That is Going to Be greater than 50 characters so it is invalid",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having an invalid Question3"
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:"",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Question3"
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:" ",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite having a blank Question3"
  end

  test "bad request response from missing email" do
    post "/register", params: {password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the email parameter"
  end

  test "bad request response from missing password" do
    post "/register", params: {Email: "validemail1@test.com",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the password parameter"
  end

  test "bad request response from missing passwordcheck" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the passwordcheck parameter"
  end

  test "bad request response from missing first name" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the FirstName parameter"
  end

  test "bad request response from missing SurName" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",Company: "hexcore",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the SurName parameter"
  end

  test "bad request response from missing Company" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the Company parameter"
  end

  test "bad request response from missing JobTitle" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the JobTitle parameter"
  end

  test "bad request response from missing Question1" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the Question1 parameter"
  end

  test "bad request response from missing Question2" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the Question2 parameter"
  end

  test "bad request response from missing Question3" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question2:"Test question 2",Answer1:"Test answer 1",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the Question3 parameter"
  end

  test "bad request response from missing Answer1" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer2:"Test answer 2",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the Answer1 parameter"
  end

  test "bad request response from missing Answer2" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer3:"Test answer 3",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the Answer2 parameter"
  end

  test "bad request response from missing Answer3" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2",AvatarID:1}
    assert_response 400, "did not get 400 response despite missing the Answer3 parameter"
  end
  
  test "bad request response from missing AvatarID" do
    post "/register", params: {Email: "validemail1@test.com",password: "validpassword1",passwordcheck: "validpassword1",FirstName: "Bob",SurName: "Day",Company: "hexcore",JobTitle: "marketing director",WorkEmail: "bob@hexcore.com",PhoneNum: "01234567891",Question1:"Test question 1",Question2:"Test question 2",Question3:"Test question 3",Answer1:"Test answer 1",Answer2:"Test answer 2"}
    assert_response 400, "did not get 400 response despite missing the AvatarID parameter"
  end

  test "bad request response from empty AvatarID" do
    post "/register", params: {Email: "validemail1@test.com",  password: "validpassword1",  passwordcheck: "validpassword1",  FirstName: "Bob",  SurName: "Day",  Company: "hexcore",  JobTitle: "marketing director",  WorkEmail: "bob@hexcore.com",  PhoneNum: "01234567891",  Question1:"Test question 1",  Question2:"Test question 2",  Question3:"Test question 3",  Answer1:"Test answer 1",  Answer2:"Test answer 2",  Answer3:"Test answer 3",AvatarID:nil}
    assert_response 400, "did not get 400 response despite leaving the AvatarID param empty"
  end

  test "exists responds with not found if an email that doesn't exist is used" do
    get "/exists", params: {email:"validemail1@test.com",AvatarID:1}
    assert_response 404, "Did not get a 404 response despite the email not already existing"
  end

  test "exists responds with bad request if the email parameter is missing" do
    get "/exists"
    assert_response 400, "Did not get a 400 response despite the email parameter being missing"
  end

  test "exists responds with success if an email that exists in the system" do
    user = User.create(Email:"validemail1@test.com",password:"password1234")
    user.save
    get "/exists", params: {email:"validemail1@test.com",AvatarID:1}
    assert_response 200, "Did not get a 200 response despite using an email that exists in the system"
  end
end
