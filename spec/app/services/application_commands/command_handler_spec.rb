# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCommands::CommandHandler do
  describe '#new' do
    context 'when request_body provided' do
      it 'creates a new instantiation of class' do
        request_body = 'some_request_body'

        expect do
          described_class.new(request_body)
        end.not_to raise_error
      end
    end

    context 'when no argument is passed' do
      it 'raises ArgumentError' do
        expect do
          described_class.new
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe '#call' do
    context 'when a command is found' do
      let(:request_body) { { 'data' => { 'name' => 'register' } } }

      let(:service_class) do
        service_class = instance_double(ApplicationCommands::Register)

        allow(ApplicationCommands::Register)
          .to receive(:new)
          .and_return(service_class)

        allow(service_class).to receive(:call)

        service_class
      end

      it 'initiates a class associated with the command' do
        service_class

        described_class.new(request_body).call

        expect(ApplicationCommands::Register).to have_received(:new).once
      end

      it 'uses the call method of the service class' do
        service_class

        described_class.new(request_body).call

        expect(service_class).to have_received(:call).once
      end
    end
  end
end
