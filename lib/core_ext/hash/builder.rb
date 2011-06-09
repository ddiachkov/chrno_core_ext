# encoding: utf-8
require "active_support/concern"

module CoreExt
  module Hash

    ##
    # DSL для удобного создания хешей.
    #
    module Builder
      extend ActiveSupport::Concern

      # Класс обёртка над элементом массива.
      class Builder
        ##
        # @param [Hash] root хеш, над которым проводятся манипуляции
        # @param [Array] path путь в root к текущему элементу
        #
        # @yieldparam [Builder] self
        #
        def initialize( root, path = [], &block )
          raise ArgumentError, "Hash expected" unless root.is_a? ::Hash
          raise ArgumentError, "Array expected" unless path.is_a? ::Array

          @root, @path = root, path
          yield self if block_given?
        end

        ##
        # Возвращает значение текущего элемента.
        #
        def __get_value
          # Крайний случай: 1 уровень хеша
          return @root if @path.empty?

          current_node = @root

          @path[ 0 ... -1 ].each do |node_name|
            current_node = current_node[ node_name ]
            return nil unless current_node.is_a? Hash
          end

          current_node[ @path.last ]
        end

        ##
        # Устанавливает значение элемента.
        #
        # @param [Object] key название
        # @param [Object] value значение
        #
        def __set_value( key, value )
          # Крайний случай: 1 уровень хеша
          @root[ key ] = value and return if @path.empty?

          current_node = @root

          @path.each do |node_name|
            current_node[ node_name ] = {} unless current_node[ node_name ].is_a? ::Hash
            current_node = current_node[ node_name ]
          end

          current_node[ key ] = value
        end

        ##
        # Возвращает дочерний элемент.
        #
        # @param [Object] key ключ
        # @return [Builder]
        #
        def []( key )
          self.class.new( @root, @path + [ key ] )
        end

        # @see #__set_value
        def []=( key, value )
          __set_value( key, value )
        end

        ##
        # Переопределяем method_missing таким образом, чтобы он вызывал {#[]}
        # и {#[]=} с именем метода в качестве названия.
        #
        def method_missing( name, *args )
          # setter?
          if name =~ /[^=]=$/
            raise ArgumentError unless args.count == 1
            self[ name.to_s.chop.to_sym ] = args.first
          else
            raise ArgumentError unless args.empty?
            self[ name ]
          end
        end
      end

      module InstanceMethods
        # @see CoreExt::Hash::Builder::ClassMethods#build
        def build( &block )
          raise ArgumentError, "block expected" unless block_given?
          Builder.new( self, &block )
          self
        end
      end

      module ClassMethods
        ##
        # Создаёт хеш.
        # @yieldparam [CoreExt::Hash::Builder::Builder]
        # @return [Hash]
        #
        # @example
        #   hash = Hash.build do |h|
        #     h.a = 1
        #     h.b = 2
        #     h.c.d = 3
        #     h[ "some_string" ] = 4
        #   end
        #
        #   hash #=> { a: 1, b: 2, c: { d: 3 }, "some string": 4 }
        #
        def build( &block )
          raise ArgumentError, "block expected" unless block_given?
          Builder.new( hash = self.new, &block )
          hash
        end
      end
    end
  end
end