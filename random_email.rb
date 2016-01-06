	49.times do |n|
		randomstr=([*'0a'..'9z']).shuffle.take(5).join
		puts randomstr+"#{n}@gmail.com"
	end
