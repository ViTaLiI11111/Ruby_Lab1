require 'mechanize'
require 'nokogiri'
require 'yaml'
require 'logger'
require 'open-uri'
require 'fileutils'
require 'timeout'
require_relative 'app_config_loader'
require_relative 'logger_manager'
require_relative 'item'

module MyApplicationLevitskii
  class SimpleWebsiteParser
    def initialize
      @config = AppConfigLoader.load_web_parser_config
      @logger = MyApplicationLevitskii::LoggerManager.setup
    end

    def parse_page
      url = @config['base_url']
      @logger.info("Parsing page: #{url}")
      html = URI.open(url)
      doc = Nokogiri::HTML(html)
      items = []
      doc.css('article.product_pod').each do |product|
        begin
          name = product.css(@config['selectors']['name']).attr('title').value
          price = product.css(@config['selectors']['price']).text.strip
          image_path = url + product.css(@config['selectors']['image_path']).attr('src').value
          rating = product.css(@config['selectors']['rating']).attr('class').value.split.last
          availability = product.css(@config['selectors']['availability']).text.strip
          details_link = url + product.css(@config['selectors']['details_link']).attr('href').value

          item = Item.new(
            name: name,
            price: price,
            image_path: image_path,
            rating: rating,
            availability: availability,
            details_link: details_link
          )
          items << item
        rescue StandardError => e
          @logger.error("Failed to parse product: #{e.message}")
        end
      end

      @logger.info("Parsing is finished. Found #{items.size} items.")
      items
    end
  end
end
