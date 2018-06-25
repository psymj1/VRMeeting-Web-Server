require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    user = User.create(Email:"hexcore@test.com",password:"H3llo123")
    user.save
  end
  
  test 'invalid without email address' do
    user = User.new(password: 'H3llo123')
    refute user.valid?, 'User was valid without an email'
    assert_not_nil user.errors[:Email], 'no validation error for no email present'
  end

  test 'invalid without password' do
    user = User.new(Email:'validemail1@test.com')
    refute user.valid?, 'User was valid without a password'
    assert_not_nil user.errors[:password], 'no validation error for no password present'
  end

  test 'invalid with blank email address' do
    user = User.new(Email:'',password:'H3llo123')
    refute user.valid? , 'User was valid with a blank email address'
    assert_not_nil user.errors[:Email], 'no validation error for blank email address present'
  end

  test 'invalid with blank password' do
    user = User.new(Email:'validemail1@test.com',password:'')
    refute user.valid? , 'User was valid with a blank password'
    assert_not_nil user.errors[:password], 'no validation error for blank password present'
  end

  test 'invalid when email missing a .' do
    user = User.new(Email:'validemail1@testcom',password:'H3llo123')
    refute user.valid? , 'User was valid with an email missing a .'
    assert_not_nil user.errors[:Email], 'no validation error for missing . present'
  end

  test 'invalid when email missing @' do
    user = User.new(Email:'validemail1test.com',password:'H3llo123')
    refute user.valid? , 'User was valid with an email missing a @'
    assert_not_nil user.errors[:Email], 'no validation error for missing @ present'
  end

  test 'invalid when email contains 2 @ symbols' do
    user = User.new(Email:'valid@email1@test.com',password:'H3llo123')
    refute user.valid? , 'User was valid with an Email which contained 2 @ symbols'
    assert_not_nil user.errors[:Email], 'no validation error for an Email which contained 2 @ symbols'
  end

  test 'invalid when email already exists in database' do
    user = User.new(Email:'hexcore@test.com',password:'H3llo123')
    refute user.valid? , 'User was valid despite email already existing in database'
    assert_not_nil user.errors[:Email], 'no validation error for an Email which already existed in the database'
  end

  #Criteria for a password: At least 1 letter, At least 1 number, Minimum of 8 characters

  test 'invalid when password contains no letters' do
    user = User.new(Email:'validemail1@test.com',password:'3$$$$$$$')
    refute user.valid? , 'User was valid with a password that did not have at least 1 letter'
    assert_not_nil user.errors[:password], 'no validation error for a password that does not have at least 1 letter'
  end

  test 'invalid when password contains no numbers' do
    user = User.new(Email:'validemail1@test.com',password:'T$$$$$$$')
    refute user.valid? , 'User was valid with a password that did not have at least 1 number'
    assert_not_nil user.errors[:password], 'no validation error for a password that does not have at least 1 number'
  end

  test 'invalid when password contains less than 8 characters' do
    user = User.new(Email:'validemail1@test.com',password:'T3$$$')
    refute user.valid? , 'User was valid with a password that was shorter than 8 characters'
    assert_not_nil user.errors[:password], 'no validation error for a password that is shorter than 8 characters'
  end

  test 'invalid when a password contains just less than 8 characters (7)' do
    user = User.new(Email:'validemail1@test.com',password:'T3$$$$$')
    refute user.valid? , 'User was valid with a password that was just shorter than 8 characters (7)'
    assert_not_nil user.errors[:password], 'no validation error for a password that is just shorter than 8 characters (7)'
  end

  test 'valid user' do
    user = User.new(Email:'validemail1@test.com',password:'H3llo123')
    assert user.valid? , 'User was not valid despite having valid email (validemail1@test.com) and password (H3llo123)'
  end

  test 'valid user with a . before the email @ symbol' do
    user = User.new(Email:'valid.email1@test.com',password:'H3llo123')
    assert user.valid? , 'User was not valid despite having email (valid.email1@test.com) and password (H3llo123)\nTested an email with a . before the @'
  end

  test 'valid user with more than one . after the @ symbol' do
    user = User.new(Email:'validemail1@test.co.uk',password:'H3llo123')
    assert user.valid? , 'User was not valid despite having email (validemail1@test.co.uk) and password (H3llo123)\nTested an email with more than one . after the @'
  end

  test 'valid user with a password with 8 characters' do
    user = User.new(Email:'validemail1@test.com',password:'H3llo123')
    assert user.valid? , 'User was not valid despite having email (validemail1@test.com) and password (H3llo123)\nTested a password with exactly 8 characters'
  end

  test 'valid user with a password more than 8 characters long' do
    user = User.create(Email:'validemail1@test.com',password:'Hello123456789123456789234567')
    assert user.valid? , 'User was not valid despite having email (validemail1@test.com) and password (Hello123456789123456789234567)\nTested a password with more than 8 characters'
  end

  test 'invalid with email longer than 80 characters (85)' do
    user = User.create(Email:'1234567890123456789012345678901234567890123456789012345678901234567890123@hexcore.com',password:'H3llo123')
    refute user.valid?, "User was valid with an email longer than 80 characters"
    assert_not_nil user.errors[:Email], 'no validation error for an email that is too long'
  end

  test 'invalid with password longer than 64 characters (70)' do
    user = User.create(Email:'validemail1@test.com',password:'H3llo12345H3llo12345H3llo12345H3llo12345H3llo12345H3llo12345H3llo12345')
    refute user.valid?, "User was valid with an password longer than 64 characters"
    assert_not_nil user.errors[:password], 'no validation error for an email that is too long'
  end

  test 'valid with an email exactly 80 characters long' do
    user = User.create(Email:'validemailvalidemailvalidemailvalidemailvalidemailvalidemailvalidema@hexcore.com',password:'H3llo123')
    assert user.valid?, "User was invalid with an email exactly 80 characters long"
  end

  test 'valid with a password exactly 64 characters long' do
    user = User.create(Email:'validemail1@test.com',password:'H3llo12345H3llo12345H3llo12345H3llo12345H3llo12345H3llo12345678')
    assert user.valid?, "User was invalid with an password exactly 64 characters long"
  end  
end
