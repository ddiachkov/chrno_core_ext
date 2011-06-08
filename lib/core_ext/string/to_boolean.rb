# encoding: utf-8
module CoreExt
  module String
    module ToBoolean
      ##
      # Преобразует строку в true или false.
      #
      # @example
      #   "true".to_b                  #=> true
      #   "some_non_empty_string".to_b #=> false
      #
      def to_b
        [ "true", "1", "T", "t", "yes", "+" ].include? self.downcase
      end
    end
  end
end