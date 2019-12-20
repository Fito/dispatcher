# frozen_string_literal: true

class CommandFactory
  class << self
    def build(command_type, params)
      command_class = registry[command_type]
      command_class&.new(params)
    end

    def register(command_type, command_class)
      registry[command_type] = command_class
    end

    private

    def registry
      @registry ||= {}
    end
  end
end
