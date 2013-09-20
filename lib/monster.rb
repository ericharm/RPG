require 'character'

class Monster < Character

	def self.load_monster(name)
		file = File.open("monsters.csv", 'r')
			args= {}
			file.each_line do |line|
				attributes = line.split(", ")
				if attributes[0] == name
					args[:name] = attributes[0]
					args[:player_class] = attributes[1]
					args[:gold] = attributes[2].to_i
					args[:level] = attributes[3].to_i
					args[:exp] = attributes[4].to_i
					args[:inventory] = attributes[5].to_i
					args[:maxhp] = attributes[6].to_i
					args[:hp] = args[:maxhp]
					args[:maxmp] = attributes[7].to_i
					args[:mp] = args[:maxmp]
					args[:attack] = attributes[8].to_i
					args[:defense] = attributes[9].to_f
					args[:acc] = attributes[10].to_i
				end
			end
		file.close
		Monster.new(args)
	end
end