module Initialize
  module Patch
    def run(*args)
      if @name == :load_config_initializers
        @block = lambda do |*args|
          initializers_path = "config/initializers"

          initializers = config.paths[initializers_path].existent.sort

          initializer_dependencies = Hash[
            config.initializer_dependencies.map do |initializer, dependencies|
              [
                "#{config.root}/#{initializers_path}/#{initializer}.rb",
                dependencies.map do |dependency|
                  "#{config.root}/#{initializers_path}/#{dependency}.rb"
                end
              ]
            end
          ]

          independent_initializers = initializers.select do |initializer|
            !initializer_dependencies.key?(initializer)
          end

          dependent_initializers = initializers - independent_initializers

          initializers = independent_initializers + dependent_initializers

          initializers.each do |initializer|
            load_config_initializer(initializer)
          end
        end
      end

      @context.instance_exec(*args, &block)
    end
  end

  ::Rails::Initializable::Initializer.send :prepend, Patch
end
