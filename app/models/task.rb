class Task < ApplicationRecord
	#validates :description, presence: true
	#validates :completed, presence: true
	#scope :for_current_user, ->(user) { where(user: user) }
	#!Nasser: From GPT
	#? Nasser:  will be uncomment soon
	#belongs_to :user
	#enum role: { system: 0, user: 20 }
	include Counter
	
	

	
end
