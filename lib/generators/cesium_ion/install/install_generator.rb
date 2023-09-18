module CesiumIon
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_initializer
        template 'cesium_ion.rb', 'config/initializers/cesium_ion.rb'
      end
    end
  end
end
