require_relative 'base_adapter'
require_relative 'base_command'
require_relative 'command_factory'
require_relative 'dispatcher'

# define port specific adapters
class SQSAdapter < BaseAdapter
end

# define application specific commands
class ExampleCommand < BaseCommand
end

# register commands
CommandFactory.register(:example, ExampleCommand)

# start worker
class SQSWorker
  # include Shoryuken::Worker
  # shoryuken_options queue: 'test_queue', body_parser: :json

  def perform(sqs_message, body)
    adapter = SQSAdapter.new(sqs_message)
    Dispatcher.new(adapter: adapter).dispatch(body)
  end
end
