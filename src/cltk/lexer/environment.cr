module CLTK
  class Lexer
    # All actions passed to LexerCore.rule are evaluated inside an
    # instance of the Environment class or its subclass (which must have
    # the same name).  This class provides functions for manipulating
    # lexer state and flags.
    # see http://carc.in/#/r/1i9
    class Environment
      # @return [Array<Symbol>] Flags currently set in this environment.
      getter :flags

      # @return [Match] Match object generated by a rule's regular expression.
      property :match

      # Instantiates a new Environment object.
      #
      # @param [Symbol]	start_state	Lexer's start state.
      # @param [Match]	match		Match object for matching text.

      @state : Array(Symbol)
      @match : Regex::MatchData?

      def match
        @match.as(Regex::MatchData)
      end

      def initialize(start_state, @match = nil)
        @state	= [start_state]
        @flags	= [] of Symbol
      end

      # Pops a state from the state stack.
      #
      # @return [void]
      def pop_state
        @state.pop

        nil
      end

      # Pushes a new state onto the state stack.
      #
      # @return [void]
      def push_state(state)
        @state << state
        nil
      end

      # Sets the value on the top of the state stack.
      #
      # @param [Symbol] state New state for the lexing environment.
      #
      # @return [void]
      def set_state(state)
        @state[-1] = state
        nil
      end

      # @return [Symbol] Current state of the lexing environment.
      def state
        @state.last
      end

      # Sets a flag in the current environment.
      #
      # @param [Symbol] flag Flag to set as enabled.
      #
      # @return [void]
      def set_flag(flag)
        unless @flags.includes?(flag)
          @flags << flag
        end
        nil
      end

      # Unsets a flag in the current environment.
      #
      # @param [Symbol] flag Flag to unset.
      #
      # @return [void]
      def unset_flag(flag)
        @flags.delete(flag)
        nil
      end

      # Unsets all flags in the current environment.
      #
      # @return [void]
      def clear_flags
        @flags = Array(Symbol).new
        nil
      end
    end
  end
end
