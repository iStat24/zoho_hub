
module ZohoHub
  class PhoneBridge::CallNotify < ZohoHub::PhoneBridge
    class << self
      def notify(connection, params = {})
        form_data = URI.encode_www_form(params)
        post(connection, request_path, form_data)
      end
    end
  end
end
