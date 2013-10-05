module BattleHelper

  def attack
    hit(@first_striker, @second_striker) 
    hit(@second_striker, @first_striker) unless @second_striker.dead?
    check_for_fatal_blow
    battle_menu unless @first_striker.dead? || @second_striker.dead?
  end

  def zap

  end

  def charge

  end

  def run
    dice_count = @player.player_class == "Rogue" ? 3 : 2
    p = roll_dice(dice_count)
    puts p
    if p < 7
      puts "Failed to escape."
      hit(@monster, @player)
      check_for_fatal_blow
      battle_menu unless @player.dead?
    else
      puts "Got away safely. . ."
    end
  end

  def roll_dice(dice_count)
    roll = 0
    dice_count.times { roll += rand(1..6) }
    roll
  end

  def check_for_fatal_blow
    if @monster.dead?
      puts "#{@monster.name} has been killed!"
      victory
    elsif @player.dead?
      puts "#{@player.name} has been killed!"
      puts "\n > > >  You have died!  < < <\n"
      Game.game_over
    end
  end

  def fight
    until @first_striker.dead? || @second_striker.dead?
      hit(@first_striker, @second_striker) 
      hit(@second_striker, @first_striker) unless @second_striker.dead?
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
    puts @monster.list_stats
  end

  def hit(attacker, attacked)
    hit_bonus = rand(100..200).to_f/100
    hit_strength = (attacker.attack * hit_bonus - attacked.defense).to_i
    hit_strength = attacked.hp if hit_strength > attacked.hp
    hit_strength = 0 if determine_miss attacker || hit_strength < 0
    attacked.change_stat(:hp, hit_strength, :subtract)
    if hit_strength > 0
      puts "#{attacker.name} hits #{attacked.name} for #{hit_strength} hit points."
    else
      puts "#{attacker.name} misses #{attacked.name} entirely!"
    end
    print "#{attacker.name} HP: #{attacker.hp} / #{attacker.maxhp} . . ."
    puts " #{attacked.name} HP: #{attacked.hp} / #{attacked.maxhp}"
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

end