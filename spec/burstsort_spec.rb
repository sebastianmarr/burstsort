require "burstsort"

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
  
end