require "test/unit"

class BurstSortTest < Test::Unit::TestCase
  
  def setup
    # collect an array of words from dictionary files
    @hamlet = (File.new("test/data/hamletwords").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
    @words = (File.new("/usr/share/dict/words").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
    #extract all uniqe characters from input words and create a sorted alphabet of them
    @hamlet_alphabet = (@hamlet.join.chars.to_a.uniq << "").sort
    @words_alphabet = (@words.join.chars.to_a.uniq << "").sort
  end
  
  def test_sort_hamlet
    assert_equal(@hamlet.sort, BurstSort::run(@hamlet, @hamlet_alphabet, 1000))
  end
  
  def test_sort_words
    assert_equal(@words.sort, BurstSort::run(@words, @words_alphabet, 8192))
  end
end