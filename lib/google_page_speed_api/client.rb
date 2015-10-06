require_relative 'middleware/status_check'
require_relative 'middleware/json_parsing'

module GooglePageSpeedAPI

  class Error < StandardError; end
  class RequestFailure < Error; end

  PageSpeedOverview = Struct.new(:site_address, :strategy, :speed, :usability)
  PageSpeedStats = Struct.new(:stats)

  class Client

    attr_reader :api_key, :page_speed

    def initialize
      @api_key = ENV['GOOGLE_PAGE_SPEED_API_KEY']
      @page_speed = "https://www.googleapis.com/pagespeedonline/v2/runPagespeed"
    end

    def create_page_speed_insight(website, strategy_type)
      all_strategy_results = []

      strategy_type.each do |strategy|

        individual_strategy_results = []

        url = "#{page_speed}?url=#{website}&strategy=#{strategy}&key=#{api_key}"

        response = connection.get url
        site_analysis = response.body

        page_speed_overview = PageSpeedOverview.new(
          site_analysis["id"],
          strategy,
          site_analysis["ruleGroups"]["SPEED"]["score"],
          site_analysis["ruleGroups"]["USABILITY"]["score"]
        )

        page_speed_stats = PageSpeedStats.new(site_analysis["pageStats"])

        individual_strategy_results << page_speed_overview
        individual_strategy_results << page_speed_stats

        all_strategy_results << individual_strategy_results
      end

      all_strategy_results
    end

    private

    def connection
      @connection ||= Faraday::Connection.new do |builder|
        builder.use Middleware::StatusCheck
        builder.use Middleware::JSONParsing

        builder.adapter Faraday.default_adapter
      end
    end

  end

end