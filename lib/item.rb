class Item

	@@stats = ["hp","mp"]
	@@types = ["Consumable","Weapon","Armor"]

	attr_accessor :name, :type, :stat, :effect

	def initialize(args={})
		@name = args[:name]
		@type = args[:type]
		@stat = args[:stat]
		@effect = args[:effect]
	end

	def use(target)
		puts stat
		case stat
		when "hp"
			target.hp+=@effect
		end
		puts "#{target}'s #{self.stat.to_s} changed by #{self.effect}."
		# puts "#{target}'s HP: #{target.hp}"
	end

end