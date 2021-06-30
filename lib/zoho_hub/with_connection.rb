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

      def post(connection, path, params = {}.to_json)
        connection ||= ZohoHub.connection
        connection.post(path, params)
      end

      def put(connection, path, params = {}.to_json)
        connection ||= ZohoHub.connection
        connection.put(path, params)
      end

      def delete(connection, path)
        connection ||= ZohoHub.connection
        connection.delete(path)
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

    def delete(connection, path)
      self.class.delete(connection, path)
    end
  end
end
