require 'monster'
require 'player'

class Battle

  attr_accessor :player, :monster, :bestiary, :first_striker, :second_striker

  def initialize
    @player = Player.player_one
    @bestiary = [ "Bat", "Skeleton", "Wolf", "Spider", "Bandit" ]
    random_monster =  rand @bestiary.length
    @monster = Monster.load_monster @bestiary[random_monster]
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
    @player.save
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
    # if attacked.defense > hit_strength
    hit_strength = attacked.hp if hit_strength > attacked.hp
    hit_strength = 0 if determine_miss attacker
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

end