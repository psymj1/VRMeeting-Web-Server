class User < ApplicationRecord
	has_secure_password
	#check whether these attributes are empty or not
	validates :Email, :password,  presence: true
	#check the length of input strings
	validates :Email, length: { maximum: 80 }
	#check the uniqueness
	validates :Email, uniqueness: true

	#Checks for:
	#1 or more none @ characters
	#then an @ symbol
	#then 1 more none @ or . characters
	#then 1 or more (. followed by 1 or more non @ or . characters) 
	validates :Email, format: { with: /\A([^@])+@([^@\.])+(\.([^@\.])+)+\z/, message:"The email is in an invalid format"}

	#validates that the password:
	#has at least 1 letter
	#has at least 1 number
	#is at least 8 characters long
	#is at most 64 characters long
	validates :password, format: { with: /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,64}\z/ , message: "The password must be: At least 8 characters, at most 64 Contain at least 1 letter and Contain 1 number"}

	has_one :userfile, :foreign_key => :Uid, :primary_key => :Uid
end
