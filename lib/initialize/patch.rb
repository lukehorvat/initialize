module Initialize
  module Patch
    def run(*args)
      if @name == :load_config_initializers
        @block = lambda do |*args|
          config.initializers.map do |initializer|
            "#{config.root}/config/initializers/#{initializer}.rb"
          end.each do |initializer|
            load_config_initializer(initializer)
          end
        end
      end

      @context.instance_exec(*args, &block)
    end
  end

  ::Rails::Initializable::Initializer.send :prepend, Patch
end
