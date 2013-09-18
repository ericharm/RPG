require 'character'

class Monster < Character

# later use this one-line method to load and save all characters
# possibly allow multiple player saves and (obviously) allow a bestiary
# with more than one monster

	# def load_monster
	# 	file = File.open("monsters.csv", 'r')
	# 		line = file.gets
	# 		attributes = line.split(", ")

	# 		@name = attributes[0]
	# 		@level = attributes[1].to_i
	# 		@hp = attributes[2].to_i
	# 		@maxhp = @hp
	# 		@mp = attributes[3].to_i
	# 		@maxmp = @mp
	# 		@attack = attributes[4].to_i
	# 		@defense = attributes[5].to_i
	# 		@acc = attributes[6].to_f
	# 		@gold = attributes[7].to_i
	# 		@exp = attributes[8].to_i
	# 	file.close
	# end

end