class Meeting < ApplicationRecord

  #check the presence of foreign key
  belongs_to :User, :foreign_key => :Uid
  validates :User, presence: true

  #check whether these attributes are empty or not
  validates :MeetingName, :MeetingCode, presence: true

  #check the length of input strings
  validates :MeetingName, length: { maximum: 40 }
  validates :MeetingCode, length: { maximum: 40 }


end
