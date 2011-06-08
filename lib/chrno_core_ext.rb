# encoding: utf-8
module CoreExt
  autoload :VERSION, "core_ext/version"

  class Railtie < Rails::Railtie
    # Подключаем нашу библиотеку
    initializer "core_ext.initialization" do
      puts "--> load core_ext"

      # Загрузить все расширения из подкаталогов каталога core_ext
      Dir.glob( File.join( File.dirname( __FILE__ ), "core_ext", "*", "**", "*.rb" )) do |f|
        require f

        # "/path/to/file" --> [ path", "to", "file" ]
        path_components = f.split( File::SEPARATOR )

        # [ "RAILS_ROOT", "vendor", "gems", ..., "core_ext", "hash", ... ] --> [ "hash", ... ]
        path_components.shift( File.dirname( __FILE__ ).split( File::SEPARATOR ).length + 1 )

        #  ..., "file.rb" ] --> ..., "file" ]
        path_components[ -1 ] = File.basename( path_components[ -1 ], ".rb" )

        # [ "core_class", "extension_name" ] --> [ "CoreClass", "ExtensionName" ]
        path_components.map! { |p| p.camelcase }

        # Получаем базовый класс
        core_class = Object.const_get( path_components.first )

        # Получаем модуль расширения
        extension_module = path_components.inject( CoreExt ) { |mod, name| mod.const_get( name ) }

        # Подмешиваем
        # puts "!!! #{core_class.name}: include #{extension_module.name}"
        core_class.send :include, extension_module
      end
    end
  end
end