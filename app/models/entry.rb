class Entry < ApplicationRecord
	# 複数の参加者一人一人にユーザーIDとルーム
	belongs_to :uesr
	belongs_to :room
end
