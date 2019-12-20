# frozen_string_literal: true

require 'spec_helper'
require_relative '../command_factory'

describe CommandFactory do
  describe '#build' do
    subject(:build) { described_class.build(command_type, params) }

    let(:params) { { body: 'message body' } }
    let(:command_type) { :do_something }

    context 'when there is NO command corresponding to the command type' do
      it { should be_nil }
    end

    context 'when there is a command corresponding to the command type' do
      let(:anonymous_class) { Class.new { def initialize(arg); end } }
      let(:built_instance) { instance_double(anonymous_class) }

      before do
        allow(anonymous_class).to receive(:new).and_return(built_instance)
        described_class.register(:do_something, anonymous_class)

        build
      end

      it 'builds the command with the params' do
        expect(anonymous_class).to have_received(:new).with(params)
      end

      it 'returns the built command' do
        expect(build).to eq(built_instance)
      end
    end
  end
end
