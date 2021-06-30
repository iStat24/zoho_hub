module ZohoHub
  class PhoneBridge::Integrate < ZohoHub::PhoneBridge
    class << self
      def enabled(connection)
        post(connection, request_path)
      end

      def disabled(connection)
        delete(connection, request_path)
      end
    end
  end
end
