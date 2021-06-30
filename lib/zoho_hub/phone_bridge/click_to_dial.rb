
module ZohoHub
  class PhoneBridge::ClickToDial < ZohoHub::PhoneBridge
    class << self
      def enabled(connection, params = {})
        form_data = URI.encode_www_form(params)
        post(connection, request_path, form_data)
      end

      def disabled(connection, params = {})
        delete(connection, request_path, params)
      end
    end
  end
end
