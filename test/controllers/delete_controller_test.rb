require 'test_helper'

class DeleteControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do

    user = User.new(Email: "test9@test.com", password: "test1234")
    user.save

    post "/authenticate" , params: {email: "test9@test.com", password: "test1234"}
    assert_response 200, "Failed to login into test user"
    @authToken = JSON.parse(response.body)["auth_token"]

  end

  test "delete user - email address not specified" do

    post "/delete", headers:{"Authorization": @authToken}
    assert_response 400, "email address not specified"

  end

  test "delete user - email address not found" do

    post "/delete" ,headers:{"Authorization": @authToken}, params: { Email:"test777@test.com"}
    assert_response 204, "email address not found"

  end


  test "delete user" do

    assert User.exists?(Email:"test9@test.com")

    post "/delete" ,headers:{"Authorization": @authToken}, params: { Email:"test9@test.com"}

    assert_response 200

    assert !User.exists?(Email:"test9@test.com")

  end



end
