# frozen_string_literal: true

class BaseCommand
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def perform; end
end
