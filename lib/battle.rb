require 'monster'
require 'player'
require 'battle_helper'

class Battle

  include BattleHelper

  attr_accessor :player, :monster, :bestiary, :first_striker, :second_striker, :levelcap

  def initialize
    @player = Player.player_one
    @levelcap = 5
    @bestiary = Monster.monsters_list
    create_monster
    fight
  end

  def fight
    puts "\n > > > FIGHT!"
    determine_first_strike
    until @first_striker.is_dead? || @second_striker.is_dead?
      hit(@first_striker, @second_striker) 
      hit(@second_striker, @first_striker) unless @second_striker.is_dead?
    end

    if @first_striker.is_dead?
      puts "#{@first_striker.name} has been killed!"
    else
      puts "#{@second_striker.name} has been killed!"
    end

    if @player.is_dead?
      puts "You have died!"
      Game.game_over
    else
      victory
    end

  end

  def determine_first_strike
    level_gap = (@monster.level.to_i - @player.level.to_i) + 2
    who_goes_first = rand level_gap
    if who_goes_first == 0
      @first_striker = @player
      @second_striker = @monster
    else
      @first_striker = @monster
      @second_striker = @player
    end
    puts "#{@first_striker.name} approaches #{@second_striker.name}!"
  end

  def hit(attacker, attacked)
    hit_bonus = rand(100..200).to_f/100
    hit_strength = (attacker.attack * hit_bonus - attacked.defense).to_i
    hit_strength = attacked.hp if hit_strength > attacked.hp
    hit_strength = 0 if determine_miss attacker || hit_strength < 0
    attacked.hp -= hit_strength
    puts "#{attacker.name} hits #{attacked.name} for #{hit_strength} hit points."
    print "#{attacker.name} HP: #{attacker.hp} / #{attacker.maxhp} . . ."
    print " #{attacked.name} HP: #{attacked.hp} / #{attacked.maxhp}\n"
  end

  def determine_miss(attacker)
    roll = rand(attacker.acc)
    if roll < 100-attacker.acc
      puts "MISS!"
      return true
    else
      return false
    end
  end

  def victory
    @player.gold += @monster.gold
    @player.exp += @monster.exp
    puts "#{@player.name} receives #{@monster.gold} Gold and #{@monster.exp} Exp."
    get_level
  end

end