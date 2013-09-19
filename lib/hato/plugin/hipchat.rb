require 'hato/plugin'
require "hato/plugin/hipchat/version"

require 'uri'
require 'net/http'

module Hato
  module Plugin
    class Hipchat < Base
      def notify(args)
        room = config.room
        room = [room] if room.is_a?(String)

        room.each do |r|
          send_message(r, args[:message])
        end
      end

      protected

      def send_message(room, message = '')
        url = 'https://api.hipchat.com/v1/rooms/message?auth_token=%s&format=json' % config.auth_token
        params = {
          'room_id' => room,
          'message' => message,
          'color'   => config.color || 'green',
          'from'    => config.from || 'hato',
          'notify'  => config.notify || 0
        }
        send_request(url, params)
      end

      def send_request(url, params)
        Net::HTTP.post_form URI.parse(url), params
      end
    end
  end
end
