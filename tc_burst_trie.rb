require "test/unit"
require_relative "burst_trie"

class BurstTrieTest < Test::Unit::TestCase
  
  def setup
    # collect an array of words from dictionary files
    @dict = (File.new("dictwords").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
    @hamlet = (File.new("hamletwords").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
    # extract all uniqe characters from input words and create a sorted alphabet of them
    @hamletalphabet = (@hamlet.join.chars.to_a.uniq << "").sort
    @dictalphabet = (@dict.join.chars.to_a.uniq << "").sort
  end
  
  def test_burst
    t = BurstTrie.new(@hamletalphabet, 1000)
    @hamlet.each { |w| t.insert(w) }
    t.containers.each do |c|
      assert(c.length <= 1000, "Container too big")
    end
  end

  # the burst limit has to be at least the count of the most duplicated
  # word
  def test_duplicates
     t = BurstTrie.new(@hamletalphabet, 1)
     assert_raise(ArgumentError) { 2.times { t.insert("foo") } }
  end
end