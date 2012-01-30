require "burstsort/burst_trie"

module BurstSort
  
  def self.run(strings, alphabet, burst_limit)
    t = BurstTrie.new(alphabet, burst_limit)
    strings.each do |s|
      t.insert(s)
    end
    sorted = []
    t.buckets.each do |c|
      sorted.concat c.sort
    end
    return sorted
  end
end
