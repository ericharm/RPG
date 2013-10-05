require 'monster'
require 'player'
require 'battle_helper'

class Battle

  include BattleHelper

  attr_accessor :player, :monster, :bestiary, :first_striker, :second_striker, :levelcap

  @@choices = ['Attack', 'Zap', 'Charge', 'Item', 'Run']

  def initialize
    @player = Player.player_one
    @levelcap = 13
    @bestiary = Monster.monsters_list
    puts "\n > > > FIGHT!"
    create_monster
    determine_first_strike
    battle_menu
  end

  def create_monster
    roll = rand(1..6) + rand(1..6)
    level_monster_to_retrieve = @player.level + roll - 7
    level_monster_to_retrieve = 1 if level_monster_to_retrieve < 1
    level_monster_to_retrieve = @levelcap if level_monster_to_retrieve > @levelcap
    monster_name = choose_monster(level_monster_to_retrieve)
    @monster = Monster.load_monster(monster_name)
  end

  def choose_monster(monster_level)
    possible_monsters = []
    file = File.open('monsters.csv', 'r')
      file.each_line do |line|
        a = line.split(", ")
        possible_monsters << a if a[3].to_i == monster_level
      end
    file.close
    choice = possible_monsters[rand(possible_monsters.length)]
    choice[0]
  end

  def battle_menu
    p @@choices
    Game.prompt
    choice = gets.chomp.downcase
    case choice
      when 'attack'
        attack
      when 'zap'
        zap
      when 'charge'
        charge
      when 'run'
        run
      else
        battle_menu
    end
  end

  def get_level
    level_data = []
    file = File.open('levels.csv','r')
    file.each_line do |line|
      level_data_as_strings = line.split(", ")
      if level_data_as_strings[0].to_i == @player.level
        level_data_as_strings.each { |value| level_data << value.chomp.to_i }
      end
    end
    file.close
    level_up(level_data) if @player.exp >= level_data[1]
  end

  def level_up(data)
      puts "#{@player.name} has leveled up!"
      stat_mod = data[2]
      @player.level += 1
      @player.exp_next = data[3]
      @player.maxhp += rand(stat_mod)
      @player.maxmp += rand(stat_mod)
      @player.hp = @player.maxhp
      @player.mp = @player.maxmp
      @player.attack += rand(stat_mod)
      @player.defense += rand(stat_mod)
      @player.acc += 1
  end

  def victory
    @player.change_stat(:gold, @monster.gold)
    @player.change_stat(:exp, @monster.exp)
    puts "#{@player.name} receives #{@monster.gold} Gold and #{@monster.exp} Exp."
    get_level
  end

end