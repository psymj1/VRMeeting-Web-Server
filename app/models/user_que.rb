class UserQue < ApplicationRecord

	#check the presence of foreign key
	# belongs_to :User, :foreign_key => :Uid, :primary_key => :Uid
	# has_one :security_que, :foreign_key => :Qid, :primary_key => :Qid
	# validates :User, :security_que, presence: true
	
	# #check whether these attributes are empty or not
	# validates :Ans, presence: true
	
	# #check the length of input strings
	# validates :Ans, length: { maximum: 20 }
	
end
