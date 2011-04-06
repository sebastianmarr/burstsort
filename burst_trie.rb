class BurstTrie
  
  def initialize(alphabet, burst_limit)
    @burst_limit = burst_limit
    @init_pointers =  alphabet.inject({}) { |pointers, character| pointers[character] = nil; pointers}
    @root = Node.new(0, @init_pointers, @burst_limit)
  end
  
  def insert(string)
     @root.insert(string)
  end
  
  def prefix(string)
    return @root.prefix(string)
  end
  
  class Node

    def initialize(depth, pointer_hash, burst_limit)
      @depth = depth
      @holy_pointers = pointer_hash
      @pointers = @holy_pointers.dup
      @burst_limit = burst_limit
    end
    
    def <<(string)
      insert(string)
    end
    
    def insert(string)
      character = string[@depth]
      if character.nil?
        character = ""
      end
      if @pointers[character].nil?
        @pointers[character] = []
      end
      @pointers[character] << string
      if @pointers[character].respond_to?(:length) && @pointers[character].length > @burst_limit
        container = @pointers[character]
        @pointers[character] = Node.new(@depth + 1, @holy_pointers, @burst_limit)
        container.each { |string| @pointers[character].insert(string)}
      end
    end
  end
end