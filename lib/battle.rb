require 'monster'
require 'player'

class Battle

	# a way to do this without using class variables?
	@@player
	@@monster

	@@first_striker
	@@second_striker

	def initialize
		@@player = Player.player_one
		@@monster = Monster.load_character_from_file(:monster)
		determine_first_strike
		fight
	end

	def determine_first_strike
		level_gap = (@@monster.level.to_i - @@player.level.to_i) + 2
		who_goes_first = rand(level_gap)
		if who_goes_first == 0
			@@first_striker = @@player
			@@second_striker = @@monster
		else
			@@first_striker = @@monster
			@@second_striker = @@player
		end

		puts "#{@@first_striker.name} approaches #{@@second_striker.name}!"
	end

	def determine_miss

	end

	def fight
		until @@first_striker.is_dead? || @@second_striker.is_dead?
			hit(@@first_striker, @@second_striker) 
			hit(@@second_striker, @@first_striker) unless @@second_striker.is_dead?
		end

		if @@first_striker.is_dead?
			puts "#{@@first_striker.name} has been killed!"
		else
			puts "#{@@second_striker.name} has been killed!"
		end

		if @@player.is_dead?
			puts "You have died!"
			exit
		else
			@@player.gold += @@monster.gold
			@@player.exp += @@monster.exp
			puts "#{@@player.name} receives #{@@monster.gold} Gold and #{@@monster.exp} Exp."
		end
		@@player.save
	end

	def hit(attacker, attacked)
		determine_miss
		hit_strength = (attacker.attack - attacked.defense) + attacker.attack
		hit_strength = attacked.hp if hit_strength > attacked.hp
		attacked.hp -= hit_strength
		puts "#{attacker.name} hits #{attacked.name} for #{hit_strength} hit points."
		print "#{attacker.name} HP: #{attacker.hp} / #{attacker.maxhp} . . ."
		print " #{attacked.name} HP: #{attacked.hp} / #{attacked.maxhp}\n"
	end

	def roll
		rand(0.7..1.3)
	end

end