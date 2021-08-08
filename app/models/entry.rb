class Entry < ApplicationRecord
	# 複数の参加者一人一人にユーザーIDとルーム
	belogs_to :uesr
	belogs_to :room
end
