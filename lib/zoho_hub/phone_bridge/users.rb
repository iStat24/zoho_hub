
module ZohoHub
  class PhoneBridge::Users < ZohoHub::PhoneBridge
    class << self
      def list(connection)
        get(connection, request_path)
      end
    end
  end
end
