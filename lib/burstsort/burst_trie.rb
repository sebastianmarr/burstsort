module BurstSort

  class BurstTrie  

    def initialize(alphabet, burst_limit, &access_property)
      # find biggest char value in alphabet
      $init_node = Array.new(alphabet.join.bytes.max + 1)
      $burst_limit = burst_limit
      if block_given?
        @accessor = access_property
      else
        @accessor = Proc.new { |x| x }
      end
      @root = Node.new(0, @accessor)
    end

    def insert(string)
      @root.insert(string)
    end

    def buckets
      return @root.buckets_recursive
    end

    def prefixes
      return @root.prefixes_recursive("")
    end
    
    def node_count
      return @root.node_count_recursive
    end

    class Node

      def initialize(depth, access_property)
        @depth = depth
        @accessor = access_property
        # clean set of nil pointers
        @pointers = $init_node.dup
      end

      def insert(string)
        # find array index of character at depth of the string
        character = (@accessor.call(string))[@depth]
        if character.nil?
          index = 0;
        else
          index = character.ord
        end

        # intitalize bucket if nil pointer at index
        if @pointers[index].nil?
          @pointers[index] = Array.new()
        end

        # do different things depending on bucket or node
        if @pointers[index].kind_of? Array # bucket
          @pointers[index] << string
          # bucket full => burst
          if @pointers[index].length > $burst_limit
            # cache old (full) bucket
            old_bucket = @pointers[index]
            # initalize new node at pointer destination
            @pointers[index] = Node.new(@depth + 1, @accessor)
            # insert old bucket onto new node
            begin
              old_bucket.each { |s| @pointers[index].insert(s) }
            rescue SystemStackError
              raise ArgumentError, "Container size must be at least the count of the most duplicate string"
            end
          end
        else                                     # node
          @pointers[index].insert(string)
        end
      end

      def buckets_recursive 
        buckets = []
        @pointers.each do |pointer|
          if pointer.kind_of? Node
            buckets.concat pointer.buckets_recursive
          elsif pointer.kind_of? Array
            buckets << pointer
          end
        end
        return buckets
      end

      def prefixes_recursive(prefix_until_here)
        prefixes = []
        @pointers.each_index do |index|
          next_prefix = String.new(prefix_until_here) << index        
          if @pointers[index].kind_of? Node
            prefixes.concat @pointers[index].prefixes_recursive(next_prefix)
          elsif @pointers[index].kind_of? Array
            prefixes << next_prefix
          end
        end
        return prefixes
      end
      
      def node_count_recursive
        count = 1
        @pointers.each do |pointer|
          if pointer.kind_of? Node
            count = count + pointer.node_count_recursive
          end
        end
        return count
      end
    end
  end
end