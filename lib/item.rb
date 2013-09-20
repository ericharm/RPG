class Item

	attr_accessor :name, :type, :stat, :effect, :price,
		:equipped, :equipable, :usable

	def self.load_item_from_file(name)
		file = File.open('items.csv', 'r')
			args = {}
			file.each_line do |line|
				attributes = line.split(", ")
				if attributes[0] == name
					args[:name]	= attributes[0]
					args[:type] = attributes[1]
					args[:stat] = attributes[2]
					args[:effect]	= attributes[3]
					args[:price] = attributes[3]
					args[:equipped] = attributes[4]
					args[:equipable] = attributes[5]
					args[:usable] = attributes[6]
				end
			end
		file.close
		Item.new(args)
	end

	def initialize(args={})
		@name = args[:name]	#strings
		@type = args[:type]
		@stat = args[:stat]
		@effect = args[:effect]	#ints
		@price = args[:price]
		@equipped = args[:equipped] #booleans
		@equipable = args[:equipable]
		@usable = args[:usable]
	end

	def use(target)
		case stat
		when "hp"
			target.hp+=@effect.to_i
			target.hp = target.maxhp if target.hp > target.maxhp
		end
		puts "Used #{@name}"
		puts "#{target.name}'s #{@stat.to_s} changed by #{@effect}."
	end

	def is_equipped?
		return equipped
	end

	def is_equipable?
		return equipable
	end

	def is_usable?
		return usable
	end

end