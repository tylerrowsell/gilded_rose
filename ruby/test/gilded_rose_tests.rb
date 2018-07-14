require_relative '../lib/gilded_rose'
require_relative '../test_helper'


class GildedRoseTest < Minitest::Test

  def test_decreasing_item_update
    item = Item.new("+5 Dexterity Vest", 10, 20)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal 9, item.sell_in
    assert_equal 19, item.quality
  end

  def test_decreasing_item_update_past_sell
    item = Item.new("+5 Dexterity Vest", 0, 20)
    rose = GildedRose.new([item])
    rose.update_quality
    rose.update_quality
    assert_equal (-2), item.sell_in
    assert_equal 16, item.quality
  end

  def test_decreasing_item_zero_quality
    item = Item.new("+5 Dexterity Vest", 10, 0)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal 9, item.sell_in
    assert_equal 0, item.quality
  end

  def test_increasing_item
    item = Item.new("Aged Brie", 10, 0)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal 9, item.sell_in
    assert_equal 1, item.quality
  end

  def test_increasing_item_50
    item = Item.new("Aged Brie", 10, 50)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal 9, item.sell_in
    assert_equal 50, item.quality
  end

  def test_increasing_item_past
    item = Item.new("Aged Brie", 0, 40)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal (-1), item.sell_in
    assert_equal 42, item.quality
  end

  def test_backstage_pass
    item = Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 20)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal 11, item.sell_in
    assert_equal 21, item.quality
  end

  def test_backstage_pass_10
    item = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal 9, item.sell_in
    assert_equal 22, item.quality
  end

  def test_backstage_pass_5
    item = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal 4, item.sell_in
    assert_equal 23, item.quality
  end

  def test_backstage_pass_0
    item = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal (-1), item.sell_in
    assert_equal 0, item.quality
  end

  def test_legendary_item
    item = Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal 0, item.sell_in
    assert_equal 80, item.quality
  end

  def test_conjured_item
    item = Item.new("Conjure", 5, 80)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal 4, item.sell_in
    assert_equal 78, item.quality
  end

  def test_conjured_item
    item = Item.new("Conjure", 0, 80)
    rose = GildedRose.new([item])
    rose.update_quality
    assert_equal (-1), item.sell_in
    assert_equal 76, item.quality
  end

end