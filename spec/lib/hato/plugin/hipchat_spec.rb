require_relative '../../../spec_helper'
require 'hato/config'

describe Hato::Plugin::Hipchat do
  describe '#notify' do
    context 'arguments' do
      context 'room' do
        context 'when room is passed as a string' do
          subject {
            described_class.new(
              Hato::Config::Plugin.new('Hipchat') {
                room 'test'
              }
            )
          }
          before {
            allow(subject).to receive(:send_message)
          }

          it {
            expect(subject).to receive(:send_message).exactly(1).times
            subject.notify(tag: 'test', message: 'test')
          }
        end

        context 'when room is passed as an array' do
          subject {
            described_class.new(
              Hato::Config::Plugin.new('Hipchat') {
                room %w[test1 test2]
              }
            )
          }
          before {
            allow(subject).to receive(:send_message)
          }

          it {
            expect(subject).to receive(:send_message).exactly(2).times
            subject.notify(tag: 'test', message: 'test')
          }
        end
      end
    end

    context 'success' do
      subject {
        described_class.new(
          Hato::Config::Plugin.new('Hipchat') {
            room 'test'
            auth_token 'foobar'
          }
        )
      }
      before {
        allow(subject).to receive(:send_request).and_return(
          Net::HTTPSuccess.new('1.1', '200', 'success')
        )
      }

      it {
        expect {
          subject.notify(tag: 'test', message: 'test')
        }.not_to raise_error
      }
    end

    context 'failure' do
      context 'network error' do
        subject {
          described_class.new(
            Hato::Config::Plugin.new('Hipchat') {
              room 'test'
              auth_token 'foobar'
            }
          )
        }
        before {
          allow(subject).to receive(:send_request).and_raise(
            Timeout::Error.new('timeout')
          )
        }

        it {
          expect {
            subject.notify(tag: 'test', message: 'test')
          }.to raise_error(Timeout::Error)
        }
      end
    end
  end
end
