# frozen_string_literal: true

class BaseAdapter
  def invalid_message(message); end

  def command_not_found(message); end

  def command_succeeded(message); end

  def command_failed(message); end

  def command_unprocessable(message); end
end
