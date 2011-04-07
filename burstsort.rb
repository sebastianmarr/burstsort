require "yaml"
require_relative "burst_trie"

def burstsort(strings, alphabet, burst_limit)
  t = BurstTrie.new(alphabet, burst_limit)
  strings.each do |s|
    t.insert(s)
  end
  sorted = []
  t.containers.each do |c|
    sorted.concat c.sort
  end
  return sorted
end
