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
    
    describe "with a block" do
      
      before(:each) do
        @hamlet_hash = Array.new
        @hamlet.each { |word| @hamlet_hash << { :suffix => word, :position => rand } }
      end
      
      it "should work with complex array object and a block" do
        t = BurstSort::BurstTrie.new(@hamletalphabet, 1000) { |x| x[:suffix] }
        @hamlet_hash.each { |h| t.insert(h) }
        trie_elements = t.buckets.inject(0) do |memo, current|
          memo + current.length
        end
        trie_elements.should  == @hamlet_hash.length
      end
    end
    
    describe "prefixes" do
      
      it "should return all prefixes" do
        t = BurstSort::BurstTrie.new(@hamletalphabet, 1)
        t.insert "foo"
        t.insert "bar"
        t.insert "baz"
        t.insert "bzz"
        t.prefixes.should == ["bar", "baz", "bz", "f"]
      end
    end
  end
end