class BurstTrie
  
  def initialize(alphabet, burst_limit)
    @burst_limit = burst_limit
    @init_pointers =  alphabet.inject({}) { |pointers, character| pointers[character] = nil; pointers}
    @root = Node.new(0, @init_pointers, @burst_limit)
  end
  
  def insert(string)
     @root.insert(string)
  end
  
  def containers
    return @root.containers_recursive
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
        begin
          container.each { |string| @pointers[character].insert(string)}
        rescue SystemStackError
          raise ArgumentError, "Container size must be at least the count of the most duplicate string"
        end
      end
    end
    
    def containers_recursive
      containers = []
      @pointers.each do |key, pointer|
        if pointer.respond_to?(:containers_recursive) #trie node
          containers.concat pointer.containers_recursive
        elsif pointer.respond_to?(:include?) #container
          containers << pointer
        end
      end
      return containers
    end
  end
end