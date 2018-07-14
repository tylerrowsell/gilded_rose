require 'byebug'
class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      adjuster = Adjuster.new(item)
      adjuster.quality.update
    end
  end
end

class Adjuster
  attr_reader :item
  attr_reader :quality

  UPPER = ['Aged Brie']
  TICKET = ['Backstage passes to a TAFKAL80ETC concert']
  LEGENDARY = ['Sulfuras, Hand of Ragnaros']
  CONJURE = ['Conjure']

  def initialize(item)
    @item = item
    @quality = quality_matcher(item)
  end

  private

  def quality_matcher(item)
    case
    when UPPER.include?(item.name)
      QualityUpper.new(item)
    when TICKET.include?(item.name)
      QualityTicket.new(item)
    when LEGENDARY.include?(item.name)
      QualityLegendary.new(item)
    when CONJURE.include?(item.name)
      QualityConjure.new(item)
    else
      Quality.new(item)
    end
  end
end

class Quality
  attr_reader :item
  def initialize(item)
    @item = item
  end

  def update
    adjust if adjustable?
    item.sell_in += sell_in_delta
  end

  def adjust
    item.quality += value_delta
  end

  def adjustable?
    0 < item.quality
  end

  def sell_in_delta
    -1
  end

  def value_delta
    item.sell_in <= 0 ? -2 : -1
  end
end

class QualityConjure < Quality
  def value_delta
    item.sell_in <= 0 ? -4 : -2
  end
end

class QualityLegendary < Quality
  def adjustable?
    false
  end

  def sell_in_delta
    0
  end
end

class QualityTicket < Quality
  def adjustable?
    item.quality < 50
  end

  def adjust
    super
    item.quality = 0 if item.sell_in <= 0
  end

  def value_delta
    case
    when item.sell_in <=5
      3
    when item.sell_in <= 10
      2
    else
      1
    end
  end
end

class QualityUpper < Quality
  def adjustable?
    item.quality < 50
  end

  def value_delta
    item.sell_in <= 0 ? 2 : 1
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end