require "test/unit"
require_relative "burstsort"

class BurstsortTest < Test::Unit::TestCase
  
  def setup
    # collect an array of words from dictionary files
    @dict = (File.new("dictwords").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
    @hamlet = (File.new("hamletwords").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
    #extract all uniqe characters from input words and create a sorted alphabet of them
    @hamletalphabet = (@hamlet.join.chars.to_a.uniq << "").sort
    @dictalphabet = (@dict.join.chars.to_a.uniq << "").sort
  end
  
  def test_sort_dict
    assert_equal(@dict.sort, burstsort(@dict, @dictalphabet, 1000))
  end
  
  def test_sort_hamlet
    assert_equal(@hamlet.sort, burstsort(@hamlet, @hamletalphabet, 1000))
  end
end