require "test/unit"
require_relative "burstsort"

class BurstsortTest < Test::Unit::TestCase
  
  def setup
    # collect an array of words from dictionary files
    @hamlet = (File.new("hamletwords").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
    @web2 = (File.new("/usr/share/dict/words").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
    #extract all uniqe characters from input words and create a sorted alphabet of them
    @hamlet_alphabet = (@hamlet.join.chars.to_a.uniq << "").sort
    @web2_alphabet = (@web2.join.chars.to_a.uniq << "").sort
  end
  
  def test_sort_hamlet
    assert_equal(@hamlet.sort, burstsort(@hamlet, @hamlet_alphabet, 1000))
  end
  
  def test_sort_web2
    assert_equal(@web2.sort, burstsort(@web2, @web2_alphabet, 8192))
  end
end