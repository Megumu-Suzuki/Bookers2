class Message < ApplicationRecord
	# 空白のメッセージは送れない
	validates :content, presence:true
	# たくさんのメッセージそれぞれにユーザーIDとルームのID
	belogs_to :user
	belogs_to :room
end
