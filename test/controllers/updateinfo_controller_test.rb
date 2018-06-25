require 'test_helper'

class UpdateinfoControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do

    user = User.new(Email: "test9@test.com", password: "test1234")
    user.save

    userID = User.find_by_Email(user["Email"])["Uid"]
    userFile = UserFile.new
    userFile["Uid"] = userID
    userFile["FirstName"] = "test"
    userFile["SurName"] = "test"
    userFile["Company"] = "test"
    userFile["JobTitle"] = "test"
    userFile["AvatarID"] = 1000
    userFile["Question1"] = "test"
    userFile["Question2"] = "test"
    userFile["Question3"] = "test"
    userFile["Answer1"] = "test"
    userFile["Answer2"] = "test"
    userFile["Answer3"] = "test"
    userFile.save

    post "/authenticate" , params: {email: "test9@test.com", password: "test1234"}
    assert_response 200
    @authToken = JSON.parse(response.body)["auth_token"]

  end

  test "update user info - email address and password not specified" do

    post "/updateinfo", headers:{"Authorization": @authToken}, params: { Company:"Google" }
    assert_response 400, "Please enter email and password to confirm"

  end

  test "update user info - user doesn't exists" do

    post "/updateinfo" ,headers:{"Authorization": @authToken}, params: { email:"test999@test.com", password:"test1234" }
    assert_response 400, "User does not exists"

  end

  test "update user info - update FirstName" do

    post "/updateinfo" ,headers:{"Authorization": @authToken}, params: { email:"test9@test.com", password:"test1234", FirstName:"lalala" }
    assert_response 500

  end

  test "update user info - update SurName" do

    post "/updateinfo" ,headers:{"Authorization": @authToken}, params: { email:"test9@test.com", password:"test1234", SurName:"slalala" }
    assert_response 500

  end

  test "update user info - update Company" do

    post "/updateinfo" ,headers:{"Authorization": @authToken}, params: { email:"test9@test.com", password:"test1234", Company:"lalala" }
    assert_response 500

  end

  test "update user info - update JobTitle" do

    post "/updateinfo" ,headers:{"Authorization": @authToken}, params: { email:"test9@test.com", password:"test1234", JobTitle:"CTO" }
    assert_response 500

  end

  test "update user info - update WorkEmail" do

    post "/updateinfo" ,headers:{"Authorization": @authToken}, params: { email:"test9@test.com", password:"test1234", WorkEmail:"test99999@test.com" }
    assert_response 500

  end

  test "update user info - update PhoneNum" do

    post "/updateinfo" ,headers:{"Authorization": @authToken}, params: { email:"test9@test.com", password:"test1234", PhoneNum:"11111111111" }
    assert_response 500

  end





end
