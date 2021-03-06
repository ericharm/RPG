require 'player'
require 'battle'
require 'shop'

class Game

  @@actions = ['Fight', 'Shop', 'Inventory', 'Stats', 'Rest', 'Save', 'Quit']
  attr_accessor :player

  def self.prompt(text="")
    print "\n#{text} > "
  end

  def self.game_over
    puts " > > >    GAME OVER    < < <"
    exit
  end

  def actions
    @@actions
  end

  def initialize
    saved_character = File.open('player.csv', 'r').gets
    if saved_character.nil?
      Player.generate_player
      get_action
    else
      Game.prompt "Continue saved character?"
      response = gets.chomp.downcase[0]
      if response == "y"
        Player.load_player_from_file
      else
        Player.generate_player
      end
      @player = Player.player_one
      get_action
    end
  end

  def get_action
    puts "\n > > > R P G"
    print actions
    Game.prompt
    result = gets.chomp.downcase.strip
    do_action result
    get_action unless result == 'quit'
  end

  def do_action(action)
    case action
      when 'fight'
        fight = Battle.new
      when 'shop'
        shop = Shop.new(:shop)
      when 'inventory'
        @player.inventory.inv_menu # inventory
      when 'stats'
        @player.list_stats
      when 'rest'
        rest
      when 'save'
        @player.save
      when 'use'
        @player.inventory.use # use
      when 'equip'
        @player.inventory.equip
      when 'unequip'
        @player.inventory.unequip
      when 'equipped'
        @player.inventory.equipped
      when 'buy'
        shop = Shop.new(:buy)
      when 'sell'
        shop = Shop.new(:sell)
      when 'quit'
        exit
      else
        puts "I don't know that command"
    end
  end

  def rest
    puts "\n >     Rest"
    puts "\n Half your gold to rest? ( #{@player.gold} G )"
    Game.prompt("( yes/no ) ")
    choice = gets.chomp.downcase[0]
    if choice == 'y'
      @player.change_stat(:hp, @player.hp, :subtract)
      @player.change_stat(:hp, @player.maxhp)
      @player.change_stat(:mp, @player.mp, :subtract)
      @player.change_stat(:mp, @player.maxmp)
      cost = @player.gold / 2
      @player.change_stat(:gold, cost, :subtract)
      puts "\n - #{cost} Gold."
      puts "Health Restored\nMana restored."
    else
      puts "You'll be back. . ."
    end
  end

end