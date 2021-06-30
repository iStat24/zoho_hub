# frozen_string_literal: true

module ZohoHub
  class PhoneBridge < ZohoHub::BaseRecord
    class << self

      def request_path(name = nil)
        @request_path = name if name
        @request_path ||= StringUtils.demodulize(to_s).downcase
        @request_path
      end
    end
  end
end

