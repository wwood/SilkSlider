require 'bio'

module Bio
  class SequenceWindowDescriptor
    attr_reader :maximum_counts, :maximum_sequences
    def calculate(sequence_object, window_size)
      # initialise maximums
      @maximum_counts = {}
      @maximum_sequences = {}
      [:gly].each do |sym|
        @maximum_counts[sym] = 0
        @maximum_sequences[sym] = ''
      end

      sequence_object.window_search(window_size) do |str|
        num = 0
        str.scan(/g/i) {num += 1}
        if num >= @maximum_counts[:gly]
          @maximum_counts[:gly] = num
          @maximum_sequences[:gly] = str
        end
      end
    end
  end
end
