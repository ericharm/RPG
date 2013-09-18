class Inventory

	attr_accessor :contents

	def initialize
		@contents = []
	end

	def add_item(item)
		@contents << item
	end

	def list_items
		@contents.each do |item|
			puts item.name
		end
	end

	def use_item(item, target)
		item.use(target)
		puts "#{target}'s #{item.stat.to_s} changed by #{item.effect}."
		# puts "#{target}'s HP: #{target.hp}"
		remove_item(item) if item.type == "Consumable"
	end

	def remove_item(item)
		@contents.delete(item)
	end

end