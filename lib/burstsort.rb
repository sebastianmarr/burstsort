require "burstsort/burst_trie"

module BurstSort
  
  def self.run(elements, alphabet, burst_limit, &accessor)
    if !block_given?
      accessor = Proc.new { |x| x }
    end
    t = BurstTrie.new(alphabet, burst_limit, &accessor)
    elements.each do |e|
      t.insert(e)
    end
    sorted = []
    t.buckets.each do |c|
      sorted.concat c.sort { |a,b| accessor.call(a) <=> accessor.call(b) }
    end
    return sorted
  end
end
