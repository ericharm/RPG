class Character

	attr_accessor :name, :player_class, :gold, :level, :exp, :inventory,
	:hp, :mp,	:attack, :defense, :acc, :maxhp, :maxmp

	def self.load_character_from_file(type)
		filepath = 'player.csv' if type == :player
		filepath = 'monsters.csv' if type == :monster

		attributes = []
		args = {}

		file = File.open(filepath, 'r')

		file.each_line do |line|
			attributes << line.chomp
		end

		args[:name] = attributes[0]
		args[:player_class] = attributes[1]
		args[:gold] = attributes[2].to_i
		args[:level] = attributes[3].to_i
		args[:exp] = attributes[4].to_i
		args[:inventory] = attributes[5]
		args[:hp] = attributes[6].to_i
		args[:mp] = attributes[7].to_i
		args[:attack] = attributes[8].to_i
		args[:defense] = attributes[9].to_i
		args[:acc] = attributes[10].to_f

		if type == :player
			args[:maxhp] = attributes[11].to_i
			args[:maxmp] = attributes[12].to_i
			player = Player.new(args)
			@@player_one = player
		elsif type == :monster
			args[:maxhp] = args[:hp].to_i
			args[:maxmp] = args[:mp].to_i
			monster = Monster.new(args)
			@@monster = monster
		end
	end

	def initialize(args = {})
		@name = args[:name].capitalize
		@player_class = args[:player_class]
		@gold = args[:gold]
		@level = args[:level]
		@exp = args[:exp]
		@inventory = args[:inventory]
	  @hp = args[:hp]
	  @mp = args[:mp]
		@attack = args[:attack]
		@defense = args[:defense]
		@acc = args[:acc]
	  @maxhp = args[:maxhp]
	  @maxmp = args[:maxmp]
	end

	def list_stats
		puts "Name: #{@name}"
		puts "Class: #{@player_class}"
		puts "Gold: #{@gold}"
		puts "Level: #{@level}"
		puts "Exp: #{@exp}"
		puts "Inventory: #{@inventory}"
		puts "HP: #{@hp} / #{@maxhp}"
		puts "MP: #{@mp} / #{@maxmp}"
		puts "Attack: #{@attack}"
		puts "Defense: #{@defense}"
		puts "Accuracy: #{@acc}"
	end

	def is_dead?
		if @hp <= 0
			return true
		else
			return false
		end
	end
end