class Character

  attr_accessor :name, :player_class, :gold, :level, :exp, :inventory,
  :hp, :mp, :attack, :defense, :acc, :maxhp, :maxmp, :exp_next

  def initialize(args = {})
    @name = args[:name]
    @player_class = args[:player_class]
    @gold = args[:gold].to_i
    @level = args[:level].to_i
    @exp = args[:exp].to_i
    @inventory = args[:inventory]
    @hp = args[:hp].to_i
    @mp = args[:mp].to_i
    @attack = args[:attack].to_i
    @defense = args[:defense].to_i
    @acc = args[:acc].to_i
    @maxhp = args[:maxhp].to_i
    @maxmp = args[:maxmp].to_i
    @exp_next = args[:exp_next].to_i
  end

  #consider this also for battle class
  def increase(stat, amount)
    case stat
    when "hp"
      @hp += amount
    when "mp"
      @mp += amount
    when "attack"
      @attack += amount
    when "defense"
      @defense += amount
    when "gold"
      @gold +=amount
    when "exp"
      @exp +=amount
    end
    @hp = @maxhp if @hp > @maxhp
  end

  def decrease(stat, amount)
    case stat
    when "hp"
      @hp -= amount
    when "mp"
      @mp -= amount
    when "attack"
      @attack -= amount
    when "defense"
      @defense -= amount
    when "gold"
      @gold -=amount
    when "experience"
      @exp -=amount
    end
  end

  def list_stats
    puts "\n > > > #{@name.upcase}"
    puts "Class: #{@player_class}"
    puts "Exp: #{@exp} / #{@exp_next}   Level: #{@level}"
    puts "Gold: #{@gold}"
    puts "HP: #{@hp} / #{@maxhp}  MP: #{@mp} / #{@maxmp}"
    puts "Attack: #{@attack}"
    puts "Defense: #{@defense}"
    puts "Accuracy: #{@acc}"
    puts "Inventory: #{@inventory.list_items}"
  end

  def is_dead?
    if @hp <= 0
      return true
    else
      return false
    end
  end

end