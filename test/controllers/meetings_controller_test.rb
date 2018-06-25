require 'test_helper'

class MeetingsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do

    user = User.new(Email: "test9@test.com", password: "test1234")
    user.save

    post "/authenticate" , params: {email: "test9@test.com", password: "test1234"}
    assert_response 200, "Failed to login into test user"
    @authToken = JSON.parse(response.body)["auth_token"]

    #Uid in meeting must exsits prior to creating meeting
    meeting = Meeting.new(MeetingName:"TestMeeting999", MeetingCode: "tesingtesing", Uid: 1)
    meeting.save

    @getmCode = meeting["MeetingCode"]

  end

  test "createmeeting - params not specified" do

    post "/createmeeting", headers:{"Authorization": @authToken}
    assert_response 400, "Parameters lost!"

  end


  test "createmeeting" do

    post "/createmeeting" ,headers:{"Authorization": @authToken}, params: { Email:"test9@test.com", MeetingName:"TestMeeting9", DoM:"15/06/2018", ToM:"16:00"}
    assert_response 201


  end


  test "createmeeting - meeting name must be UNIQUE" do

    post "/createmeeting" ,headers:{"Authorization": @authToken}, params: { Email:"test9@test.com", MeetingName:"TestMeeting9", DoM:"15/06/2018", ToM:"16:00"}
    assert_response 201

    #testing duplicate MeetingName
    post "/createmeeting" ,headers:{"Authorization": @authToken}, params: { Email:"test9@test.com", MeetingName:"TestMeeting9", DoM:"19/06/2018", ToM:"12:00"}
    assert_response 400 , "MeetingName exists!"

  end

  test "get_presenter_id - missing parameter" do
    get "/meeting/presenter"
    assert_response 400, "400 was no returned despite the MeetingCode parameter missing"
  end

  test "get_presenter_id - meeting code doesn't exist " do
    get "/meeting/presenter?MeetingCode=fakecode123"
    assert_response 404, "404 was not returned despite the meeting code not existing in the database"
  end

  test "get_presenter_id - Blank meeting code returns does not exist" do
    get "/meeting/presenter?MeetingCode="
    assert_response 404, "404 was not returned despite no meeting code being supplied"
  end

  test "get_presenter_id - valid meeting code returns the presenter id" do
    post "/createmeeting" ,headers:{"Authorization": @authToken}, params: { Email:"test9@test.com", MeetingName:"TestMeeting9", DoM:"15/06/2018", ToM:"16:00"}
    assert_response 201
    assert_not response.body.blank? ,"The meeting code was not returned"
    result = JSON.parse(@response.body)
    assert result.key?("meeting_code"), "The meeting_code JSON was not found in the response"
    mcode = result["meeting_code"]

    get "/meeting/presenter?MeetingCode=" + mcode
    assert_response 200
    assert_not response.body.blank? ,"The response was blank"
    result = JSON.parse(@response.body)
    assert result.key?("presenter_id"), "The presenter_id JSON was not found in the response"
    
    dbMeeting = Meeting.find_by_MeetingCode(mcode)
    id_in_database = dbMeeting["Uid"]
    assert_equal id_in_database, result["presenter_id"], "The presenter id returned by the request does not match the one in the database for the given meeting"
  end

  test "join meeting" do
    post "/joinmeeting", headers:{"Authorization": @authToken}, params: { mCode: @getmCode }
    assert_response 200
  end

end
