# encoding: utf-8
module CoreExt
  module String
    module PresentParticiple
      ##
      # Преобразование английского глагола в -ing'овую форму (tag -> tagging).
      # Реализация позаимствована из библиотеки Linguistics.
      #
      # @note
      #   Реализация не полная, могут быть проблемы со специальными
      #   глаголами + нельзя работать c фразами как принято в инфлекторе
      #   рельс (eg. "CamelOctopus".pluralize -> "CamelOctopi")
      def present_participle
        word = self.singularize

        word.sub!( /ie$/, "y" )             \
          or word.sub!( /ue$/, "u" )        \
          or word.sub!( /([auy])e$/, "$1" ) \
          or word.sub!( /i$/, "" )          \
          or word.sub!( /([^e])e$/, "\\1" ) \
          or /er$/.match( word )            \
          or word.sub!( /([^aeiou][aeiouy]([bdgmnprst]))$/, "\\1\\2" )

        "#{word}ing"
      end
    end
  end
end