class BurstTrie
  
  BURST_LIMIT = 100
  
  def initialize
    @root = Node.new(0)
  end
  
  def insert(string)
     @root.insert(string)
  end
  
  class Node
    
    POINTERS = ([""] + ("a".."z").to_a + ("A".."Z").to_a).inject({}) { |pointers, letter| pointers[letter] = nil; pointers }
    
    attr_reader :pointers, :depth

    def initialize(depth)
      @depth = depth
      @pointers = POINTERS.dup
    end
    
    def insert(string)
      character = string[depth]
      if character.nil?
        character = ""
      end
      if pointers[character].nil?
        pointers[character] = Container.new
      end
      @pointers[character].insert(string)
      if !@pointers[character].length.nil? && @pointers[character].length > BURST_LIMIT
        container = @pointers[character]
        @pointers[character] = Node.new(@depth + 1)
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