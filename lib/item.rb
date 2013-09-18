class Item

	@@stats = ["hp","mp"]
	@@types = ["Consumable","Weapon","Armor"]

	attr_accessor :name, :type, :stat, :effect

	def initialize(args={})
		@name = args[:name]
		@type = args[:type]
		@stat = args[:stat]
		@effect = args[:effect].to_i
	end

	def use(target)
		puts stat
		case stat
		when "hp"
			target.hp+=effect
		end
	end

end