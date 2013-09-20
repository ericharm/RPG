class Inventory

	attr_accessor :contents

	@@choices = ["Use", "Equip", "Exit"]

	def initialize
		@contents = []
	end

	def inv_menu
		puts "\n > > > INVENTORY"
		puts list_items
		Game.prompt @@choices
		choice = gets.downcase.chomp
		do_action choice
	end

	def do_action(choice)
		case choice
			when 'use'
				use
			when 'equip'
				equip
			else
				puts "Ok."
		end
	end

	def use
		Game.prompt "Use what?"
		choice = gets.downcase.chomp.capitalize
		@contents.each do |item|
			if item.name == choice
				item.use Player.player_one
				remove_item item if item.type == "Consumable"
				break
			end
		end
	end

	def equip
		Game.prompt "Equip what?"
		#@contents.each do |item|
		# print item.name if item.equipable
		#end
		choice = gets.downcase.chomp.capitalize
		
	end

	def list_items
		names_list = []
		@contents.each do |name|
			names_list << name.name
		end
		names_list
	end

	def add_item(item)
		@contents << item
	end

	def remove_item(item)
		@contents.delete item
	end
end