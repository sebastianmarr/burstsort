module BurstSort
  
  class BurstTrie  
  
    def initialize(alphabet, burst_limit)
      # find biggest char value in alphabet
      $init_node = Array.new(alphabet.join.bytes.max)
      $burst_limit = burst_limit
      @root = Node.new(0)
    end
    
    def insert(string)
      @root.insert(string)
    end
   
    def buckets
      return @root.buckets_recursive
    end
   
    class Node
   
      def initialize(depth)
        @depth = depth
        # clean set of nil pointers
        @pointers = $init_node.dup
      end
     
      def insert(string)
        # find array index of character at depth of the string
        index = string[@depth] == nil ? 0 : string[@depth].bytes.first
        
        # intitalize bucket if nil pointer at index
        if @pointers[index].nil?
          @pointers[index] = Array.new()
        end
        
        # do different things depending on bucket or node
        if @pointers[index].respond_to?(:length) # bucket
          @pointers[index] << string
          # bucket full => burst
          if @pointers[index].length > $burst_limit
            # cache old (full) bucket
            old_bucket = @pointers[index]
            # initalize new node at pointer destination
            @pointers[index] = Node.new(@depth + 1)
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
         if pointer.respond_to?(:buckets_recursive)
           buckets.concat pointer.buckets_recursive
         elsif pointer.respond_to?(:include?)
           buckets << pointer
         end
       end
       return buckets
     end
    end
  end
end