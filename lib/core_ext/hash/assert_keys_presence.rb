# encoding: utf-8
module CoreExt
  module Hash
    module AssertKeysPresence
      ##
      # Проверяет наличие в хеше элементов с заданным ключом.
      #
      def assert_keys_presence( *keys )
        missing_keys = keys - self.keys

        unless missing_keys.empty?
          raise ArgumentError, "the following keys are missing: #{missing_keys.map { |k| k.inspect }.join( ", " )}"
        end
      end
    end
  end
end