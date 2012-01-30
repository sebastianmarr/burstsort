require_relative "../lib/burstsort"

describe "algorithm" do
  
  before(:all) do
    # collect an array of words from dictionary files
    @hamlet = (File.new("spec/data/hamletwords").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
    @words = (File.new("/usr/share/dict/words").readlines.inject([]) { |test, line| test << line.split; }).shuffle.flatten
    #extract all uniqe characters from input words and create a sorted alphabet of them
    @hamlet_alphabet = (@hamlet.join.chars.to_a.uniq << "").sort
    @words_alphabet = (@words.join.chars.to_a.uniq << "").sort
  end
  
  it "should sort the strings of hamlet" do
    BurstSort::run(@hamlet, @hamlet_alphabet, 1000).should == @hamlet.sort
  end
  
  it "should sort the unix dictionary file" do
    BurstSort::run(@words, @words_alphabet, 1000).should == @words.sort
  end
  
  describe "with a block for specifying key accessor" do
    
    before(:all) do
      @hamlet_hashes = @hamlet.inject([]) do |memo, current|
        memo << { :suffix => current, :position => rand }
      end
      @words_hashes = @words.inject([]) do |memo, current|
        memo << { :suffix => current, :position => rand }
      end
    end
    
    it "should sort hashes with hamlet words using the specified key" do
      sorted = BurstSort::run(@hamlet_hashes, @hamlet_alphabet, 1000) do |x| 
        x[:suffix]
      end
      bef = ""
      sorted.each do |element|
        element[:suffix].should >= bef
        bef = element[:suffix]
      end
    end
    
    it "should sort hashes with dictionary words using the specified key" do
      sorted = BurstSort::run(@words_hashes, @words_alphabet, 1000) do |x| 
        x[:suffix]
      end
      sorted.should == @words_hashes.sort { |a,b| a[:suffix] <=> b[:suffix] }
    end
  end
end