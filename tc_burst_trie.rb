require "test/unit"
require_relative "burst_trie"

class BurstTrieTest < Test::Unit::TestCase
  
  def setup
    @dict = (File.new("dictwords").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
    @hamlet (File.new("hamletwords").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
  end
  
  def teardown
    #nothing really
  end
  
  def test_insert
    
  end
  
end