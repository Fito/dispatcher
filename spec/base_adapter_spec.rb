# frozen_string_literal: true

require 'spec_helper'
require_relative '../base_adapter'

describe BaseAdapter do
  subject(:adapter) { described_class.new }

  let(:message) { { command: :do_something, params: { body: 'message body' } } }

  describe '#invalid_message' do
    subject(:invalid_message) { adapter.invalid_message(message) }

    it { should be_nil }
  end

  describe '#command_not_found' do
    subject(:command_not_found) { adapter.command_not_found(message) }

    it { should be_nil }
  end

  describe '#command_succeeded' do
    subject(:command_succeeded) { adapter.command_succeeded(message) }

    it { should be_nil }
  end

  describe '#command_failed' do
    subject(:command_failed) { adapter.command_failed(message) }

    it { should be_nil }
  end

  describe '#command_unprocessable' do
    subject(:command_unprocessable) { adapter.command_unprocessable(message) }

    it { should be_nil }
  end
end
