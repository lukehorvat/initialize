=begin
  Monkey-patch the "run" method of Rails::Initializable::Initializer so that it executes
  initializers in a custom order defined by the user, not alphabetical order.

  Relevant reference files from Rails core:
  - https://github.com/rails/rails/blob/v4.2.5.2/railties/lib/rails/initializable.rb
  - https://github.com/rails/rails/blob/v4.2.5.2/railties/lib/rails/engine.rb
  - https://github.com/rails/rails/blob/v4.2.5.2/railties/lib/rails/application.rb
=end

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
