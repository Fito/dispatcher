# frozen_string_literal: true

require 'spec_helper'
require_relative '../dispatcher'

describe Dispatcher do
  subject(:dispatcher) { described_class.new(adapter: adapter, command_factory: command_factory) }

  let(:adapter) {
    instance_double(
      'adapter',
      invalid_message: true,
      command_not_found: true
    )
  }
  let(:command_factory) { class_double('command_factory') }

  describe '#dispatch' do
    subject(:dispatch) { dispatcher.dispatch(message) }

    context 'when the message does NOT contain a command' do
      let(:message) { { params: {} } }

      before { dispatch }

      it 'notifies the adapter of an invalid message' do
        expect(adapter).to have_received(:invalid_message).with(message)
      end
    end

    context 'when the message contains a command' do
      let(:message) { { command: command_type, params: params } }
      let(:command_type) { :do_something }
      let(:params) { { body: 'a message body' } }
      let(:command) { nil }

      before do
        allow(command_factory).to receive(:build).and_return(command)

        dispatch
      end

      it 'asks the command factory to build a command' do
        expect(command_factory).to have_received(:build).with(command_type, params)
      end

      context 'and the command factory does NOT return a command' do
        let(:command) { nil }

        it 'notifies the adapter of a command not found' do
          expect(adapter).to have_received(:command_not_found).with(message)
        end
      end

      context 'and the command factory returns a command' do
        let(:command) { instance_double('command', perform: true) }

        it 'tells the command to perform' do
          expect(command).to have_received(:perform)
        end
      end
    end
  end
end
