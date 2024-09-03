# frozen_string_literal: true

require "csv"

module Destatis
  class Table
    attr_reader :stand, :startyear, :endyear

    def initialize(startyear:, endyear:, time: Time.zone.now)
      @startyear = startyear
      @endyear = endyear
      @stand = time.strftime("%d.%m.%y %H:%m")
    end

    def parsed_content
      CSV.parse(as_json.dig("Object", "Content") || "", col_sep: ";")
    end

    def as_json
      @as_json ||= JSON.parse(body)
    end

    def body
      @body ||= request.body
    end

    def request
      @request ||= connection.request(method: :get, query:, persistent: false).tap do |response|
        RequestLog.find_or_create_by!(
          body: response.body,
          data: response.data,
          status_code: response.status,
          class_name: self.class.name,
        )
      end
    end

    private

    def query
      @query ||= {
        username: AppConfig.destatis_setting.fetch("username"),
        password: AppConfig.destatis_setting.fetch("password"),
        name: "61111-0002",
        language: "en",
        startyear: @startyear,
        endyear: @endyear,
        stand: @stand,
      }
    end

    def connection
      @connection ||= Excon.new("https://www-genesis.destatis.de/genesisWS/rest/2020/data/table")
    end
  end
end
