require 'test_helper'

class UserFileTest < ActiveSupport::TestCase
  def setup
    @user = user_files(:valid)
  end
  
  test "valid user" do
    assert @user.valid?
  end

  # test "invalid without first security question" do
  #   @user.Question1 = nil
  #   refute @user.valid?, 'The user is valid without first security question.'
  # end

  # test "invalid without second security question" do
  #   @user.Question2 = nil
  #   refute @user.valid?, 'The user is valid without second security question.'
  # end

  # test "invalid without third security question" do
  #   @user.Question3 = nil
  #   refute @user.valid?, 'The user is valid without third security question.'
  # end

  # test "invalid without first security answer" do
  #   @user.Answer1 = nil
  #   refute @user.valid?, 'The user is valid without first security answer.'
  # end

  # test "invalid without second security answer" do
  #   @user.Answer2 = nil
  #   refute @user.valid?, 'The user is valid without second security answer.'
  # end

  # test "invalid without third security answer" do
  #   @user.Answer3 = nil
  #   refute @user.valid?, 'The user is valid without third security answer.'
  # end

  # test "invalid with a first security question that is too long" do
  #   @user.Question1 = 'This is a very long question, too long so it must be shorter to be valid'
  #   refute @user.valid?, 'The user is valid with a first security question that is too long.'
  # end

  # test "invalid with a second security question that is too long" do
  #   @user.Question2 = 'This is a very long question, too long so it must be shorter to be valid'
  #   refute @user.valid?, 'The user is valid with a second security question that is too long.'
  # end

  # test "invalid with a third security question that is too long" do
  #   @user.Question3 = 'This is a very long question, too long so it must be shorter to be valid'
  #   refute @user.valid?, 'The user is valid with a third security question that is too long.'
  # end

  # test "invalid with a first security answer that is too long" do
  #   @user.Answer1 = 'This is a very long answer, too long so it must be shorter to be valid'
  #   refute @user.valid?, 'The user is valid with a first security answer that is too long.'
  # end

  # test "invalid with a second security answer that is too long" do
  #   @user.Answer2 = 'This is a very long answer, too long so it must be shorter to be valid'
  #   refute @user.valid?, 'The user is valid with a second security answer that is too long.'
  # end

  # test "invalid with a third security answer that is too long" do
  #   @user.Answer3 = 'This is a very long answer, too long so it must be shorter to be valid'
  #   refute @user.valid?, 'The user is valid with a third security answer that is too long.'
  # end

  test "invalid without first name" do
    @user.FirstName = nil
    refute @user.valid?, 'The user is valid without first name.'
  end
  
  test "invalid with too long first name" do
    @user.FirstName = 'AVeryVeryVeryVeryLongFirstName'
    refute @user.valid?, 'The user is valid with too-long fist name.'
  end
  
  test "invalid without surname" do
    @user.SurName = nil
    refute @user.valid?, 'The user is valid without first name.'
  end
  
  test "invalid with too long surname" do
    @user.FirstName = 'AVeryVeryVeryVeryVeryLongSurName'
	refute @user.valid?, 'The user is valid with a too-long surname.'
  end

  test "invalid without company name" do
    @user.Company = nil
    refute @user.valid?, 'The user is valid without company name.'
  end
  
  test "invalid with too long company name" do
    @user.Company = 'AVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryLongCompany'
    refute @user.valid?, 'The user is valid with a too-long company name.'
  end
  
  test "invalid without job title" do
    @user.JobTitle = nil
    refute @user.valid?, 'The user is valid without job title.'
  end
  
  test "invalid with too long job title" do
    @user.JobTitle = 'AVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryLongJobTitil'
    refute @user.valid?, 'The user is valid with a too-long job title.'
  end
  
      
  test "valid without work email" do
    @user.WorkEmail = nil
    assert @user.valid?, 'The user is invalid without work email.'
  end
  
  test "invalid with too long work email" do
    @user.WorkEmail = 'AVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryVeryLongWorkEmail'
    refute @user.valid?, 'The user is valid with a long work email.'
  end
  
  test "valid without phone number" do
    @user.PhoneNum = nil
    assert @user.valid?, 'The user is invalid without phone number.'
  end
  
  test "invalid with too long phone number" do
    @user.PhoneNum = 'AVeryVeryVeryLongPhoneNum'
    refute @user.valid?, 'The user is valid with a long phone number.'
  end
end
