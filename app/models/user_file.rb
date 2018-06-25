class UserFile < ApplicationRecord

	#check the presence of foreign key
	belongs_to :User, :foreign_key => :Uid, :primary_key => :Uid
	validates :User, presence: true
	
	#check whether these attributes are empty or not
	validates :FirstName, :SurName, :Company, :JobTitle, presence: true
	
	#check the length of input strings
	validates :FirstName, length: { maximum: 15 }
	validates :SurName, length: { maximum: 20 }
	validates :Company, length: { maximum: 50 }
	validates :JobTitle, length: { maximum: 30 }

	#Check the presence of the security questions and the length of them
	validates :Question1, presence: true, length: { maximum: 50 }
	validates :Question2, presence: true, length: { maximum: 50 }
	validates :Question3, presence: true, length: { maximum: 50 }

	#Check the presence of the security answers and their length
	validates :Answer1, presence: true, length: { maximum: 20 }
	validates :Answer2, presence: true, length: { maximum: 20 }
	validates :Answer3, presence: true, length: { maximum: 20 }

	validates :WorkEmail, length: { maximum: 100 },format: { with: /\A([^@])+@([^@\.])+(\.([^@\.])+)+\z/, message:"The email is in an invalid format"},allow_nil:true

	# validates :PhoneNum, :allow_blank => true
	validates :PhoneNum, length: {is: 11}, format: {with: /\d{11}/, message: "The phone number is an invalid format"}, allow_nil:true

	validates :AvatarID, presence: true
end

