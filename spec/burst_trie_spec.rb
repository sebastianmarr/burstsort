require_relative "../lib/burstsort/burst_trie"

describe BurstSort do
  
  describe BurstSort::BurstTrie do
    
    before(:all) do
      # collect an array of words from dictionary files
      @hamlet = (File.new("spec/data/hamletwords").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
      # extract all uniqe characters from input words and create a sorted alphabet of them
      @hamletalphabet = (@hamlet.join.chars.to_a.uniq << "").sort
    end
    
    it "should burst on the given limit" do
      t = BurstSort::BurstTrie.new(@hamletalphabet, 1000)
      @hamlet.each { |w| t.insert(w) }
      t.buckets.each do |c|
        c.length.should be <= 1000
      end
    end
    
    it "should reject too many duplicates for the given limit" do
      t = BurstSort::BurstTrie.new(@hamletalphabet, 1)
      lambda { 2.times {t.insert "foo" } }.should raise_exception(ArgumentError)
    end
    
  end
end