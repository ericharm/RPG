require 'test/unit'
require '../lib/item.rb'

class ItemTest < Test::Unit::TestCase

	def test_potion_stat_is_hp
		args = { name: "Potion", stat: 'hp'}
		item = Item.new( args )
		test_stat = 'hp'
		assert_equal item.stat, test_stat, 'Potion stat is hp'
	end

end