class Inventory

	attr_accessor :contents

	@@choices = ["use","exit"]

	def initialize
		@contents = []
	end

	def inv_menu
		puts list_items
		Game.prompt(@@choices)
		choice = gets.downcase.chomp
		do_action(choice)
	end

	def do_action(choice)
		case choice
			when 'use'
				use
			else
				puts ""
		end
	end

	def use
		Game.prompt "Use what?"
		choice = gets.downcase.chomp.capitalize
		@contents.each do |item|
			if item.name == choice
				puts "#{item.name} used."
				item.use(Player.player_one)
				remove_item(item) if item.type == "Consumable"
			end
		end
	end

	def list_items
		item_list = []
		@contents.each do |item|
			item_list << item.name
		end
		return item_list
	end

	def add_item(item)
		@contents << item
	end

	def remove_item(item)
		@contents.delete(item)
	end
end