# frozen_string_literal: true

class Dispatcher
  attr_reader :adapter, :command_factory

  def initialize(adapter: BaseAdapter.new, command_factory: CommandFactory)
    @adapter = adapter
    @command_factory = command_factory
  end

  def dispatch(message)
    return adapter.invalid_message(message) unless message[:command]

    command = command_factory.build(message[:command], message[:params])
    return adapter.command_not_found(message) unless command

    command.perform
  end
end
