# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interactions::WebhookValidator do
  let(:env) do
    allow(ENV)
      .to receive(:fetch)
      .once
      .with('TESTAPP_APPLICATION_ID')
      .and_return('some_application_id')
    allow(ENV)
      .to receive(:fetch)
      .once
      .with('TESTAPP_PUBLIC_KEY')
      .and_return('some_public_key')

    env
  end

  let(:request) { test_double_request }

  describe '#new' do
    context 'when request data is provided' do
      it 'creates a class instantiation' do
        expect do
          described_class.new(request)
        end.not_to raise_error
      end
    end
  end

  describe '#call' do
    context 'when a valid request object is passed' do
      let(:request)    { test_double_request }
      let(:verify_key) { test_double_verify_key_successful }

      it 'validates using Ed25519' do
        verify_key

        described_class.new(request).call

        expect(Ed25519::VerifyKey).to have_received(:new).once
        expect(verify_key).to have_received(:verify).once
      end

      it 'gets headers data twice' do
        verify_key

        described_class.new(request).call

        expect(request).to have_received(:headers).twice
      end

      it 'gets the request body thrice' do
        verify_key

        described_class.new(request).call

        expect(request).to have_received(:body).thrice
      end

      it 'calls request.body.read' do
        verify_key

        described_class.new(request).call

        expect(request.body).to have_received(:read).once
      end

      it 'calls request.body.rewind' do
        verify_key

        described_class.new(request).call

        expect(request.body).to have_received(:rewind).twice
      end

      it 'returns a ValidatedReqeust object' do
        verify_key

        result = described_class.new(request).call

        expect(result).to eq(validated_request)
      end
    end

    context 'when headers is incomplete' do
      let(:request) { test_double_request }

      it 'raises ArgumentError exception' do
        request.headers['X-Signature-Ed25519'] = nil

        expect do
          described_class.new(request).call
        end.to raise_error(ArgumentError)
      end

      it 'returns false' do
        test_double_verify_key_failing

        result = described_class.new(request).call

        expect(result).to be false
      end
    end
  end

  private

  def test_double_request
    double(
      headers: { 'X-Signature-Ed25519' => 'some_signature', 'X-Signature-Timestamp' => '123456789' },
      body: test_double_body
    )
  end

  def test_double_body
    body = double

    allow(body).to receive(:read).and_return(
      JSON.dump(
        { 'id' => 'some_request_id', 'application_id' => 'some_application_id' }
      )
    )
    allow(body).to receive(:rewind).and_return(true)

    body
  end

  def test_double_verify_key_successful
    verify_key = instance_double(Ed25519::VerifyKey)

    allow(Ed25519::VerifyKey).to receive(:new).and_return(verify_key)
    allow(verify_key).to receive(:verify).and_return(true)

    verify_key
  end

  def test_double_verify_key_failing
    verify_key = instance_double(Ed25519::VerifyKey)

    allow(Ed25519::VerifyKey).to receive(:new).and_return(verify_key)
    allow(verify_key).to receive(:verify).and_raise(Ed25519::VerifyError)

    verify_key
  end

  def validated_request
    WebhookEvents::WebhookValidator::ValidatedRequest.new(
      'some_request_id',
      'interaction',
      { 'id' => 'some_request_id', 'application_id' => 'some_application_id' }
    )
  end
end
