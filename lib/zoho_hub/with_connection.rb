# frozen_string_literal: true

module ZohoHub
  # Adds the ability to do API requests (GET / PUT and POST requests) when included in a class.
  module WithConnection
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def get(connection, path, params = {})
        connection ||= ZohoHub.connection
        connection.get(path, params)
      end

      def post(connection, path, params = {})
        connection ||= ZohoHub.connection
        connection.post(path, params.to_json)
      end

      def put(connection, path, params = {})
        connection ||= ZohoHub.connection
        connection.put(path, params.to_json)
      end
    end

    def get(connection, path, params = {})
      self.class.get(connection, path, params)
    end

    def post(connection, path, params = {})
      self.class.post(connection, path, params)
    end

    def put(connection, path, params = {})
      self.class.put(connection, path, params)
    end
  end
end
