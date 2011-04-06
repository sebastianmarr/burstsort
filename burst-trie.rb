class BurstTrie
  
  BURST_LIMIT = 8192
  
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
    end
    
  end
  
  class Container
    
    def initialize(parent)
      @store = []
      @parent = parent
    end
    
    def insert(string)
      if @store.length == BURST_LIMIT
               burst
             end
      @store << string
    end
    
    def burst
      print "bursting now"
    end
  end
end