# frozen_string_literal: true

require 'spec_helper'
require_relative '../base_command'

describe BaseCommand do
  subject(:adapter) { described_class.new(params) }

  let(:params) { { body: 'message body' } }

  describe '#perform' do
    subject(:perform) { adapter.perform }

    it { should be_nil }
  end
end
