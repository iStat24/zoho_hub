# frozen_string_literal: true

require 'zoho_hub/response'
require 'zoho_hub/with_connection'
require 'zoho_hub/with_attributes'
require 'zoho_hub/string_utils'


module ZohoHub
  class BaseRecord
    include WithConnection
    include WithAttributes

    # Default nnumber of records when fetching all.
    DEFAULT_RECORDS_PER_PAGE = 200

    # Default page number when fetching all.
    DEFAULT_PAGE = 1

    # Minimum number of records to fetch when fetching all.
    MIN_RECORDS = 2

    class << self
      def request_path(name = nil)
        @request_path = name if name
        @request_path ||= StringUtils.pluralize(StringUtils.demodulize(to_s))
        @request_path
      end

      def find(connection, id)
        body = get(connection, File.join(request_path, id.to_s))
        response = build_response(body)

        if response.empty?
          raise RecordNotFound, "Couldn't find #{request_path.singularize} with 'id'=#{id}"
        end

        new(response.data)
      end

      def where(connection, params)
        path = File.join(request_path, 'search')

        response = get(connection, path, params)
        result = [response[:data]].flatten if response.try(:[], :data)
        data = Array(result)

        data.map { |info| new(info) }
      end

      def find_by(connection, params)
        records = where(connection, params)
        records.first
      end

      def create(connection, params)
        post(connection, request_path, data: [params])
      end

      def all(connection, options = {})
        options[:page] ||= DEFAULT_PAGE
        options[:per_page] ||= DEFAULT_RECORDS_PER_PAGE
        options[:per_page] = MIN_RECORDS if options[:per_page] < MIN_RECORDS

        body = get(connection, request_path, options)
        response = build_response(body)

        result = [response.data].flatten if response.data.any?
        data = Array(result)

        data.map { |json| new(json) }
      end

      def exists?(id)
        !find(id).nil?
      rescue RecordNotFound
        false
      end

      alias exist? exists?

      def build_response(body)
        response = Response.new(body)

        raise InvalidTokenError, response.msg if response.invalid_token?
        raise RecordInvalid, response.msg if response.invalid_data?

        response
      end
    end

    def update(connection, params)
      put(connection, self.class.request_path, data: [params.merge({'id' => id})])
    end

    def build_response(body)
      self.class.build_response(body)
    end
  end
end
