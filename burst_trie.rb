class BurstTrie
  
  def initialize(alphabet, burst_limit)
    @burst_limit = burst_limit
    @init_pointers =  alphabet.inject({}) { |pointers, character| pointers[character] = nil; pointers}
    @root = Node.new(0, @init_pointers, @burst_limit)
  end
  
  def insert(string)
     @root.insert(string)
  end
  
  class Node

    def initialize(depth, pointer_hash, burst_limit)
      @depth = depth
      @holy_pointers = pointer_hash
      @pointers = @holy_pointers.dup
      @burst_limit = burst_limit
    end
    
    def insert(string)
      character = string[@depth]
      if character.nil?
        character = ""
      end
      if @pointers[character].nil?
        @pointers[character] = Container.new
      end
      @pointers[character].insert(string)
      if !@pointers[character].length.nil? && @pointers[character].length > @burst_limit
        container = @pointers[character]
        @pointers[character] = Node.new(@depth + 1, @holy_pointers, @burst_limit)
        container.store.each { |string| @pointers[character].insert(string)}
      end
    end
    
    def length
      nil
    end
    
  end
  
  class Container
    
    attr_reader :store
  
    def initialize
      @store = []
    end
    
    def insert(string)
      @store << string
    end
    
    def length
      @store.length
    end
  end
end