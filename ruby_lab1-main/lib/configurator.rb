# frozen_string_literal: true

require_relative 'database_connector'
require_relative 'app_config_loader'

module MyApplicationLevitskii
  class Configurator
    attr_accessor :config

    # Словник для виконання команд
    DEFAULT_CONFIG = {
      run_website_parser: 1,
      run_save_to_csv: 1,
      run_save_to_json: 1,
      run_save_to_yaml: 1,
      run_save_to_sqlite: 1,
      run_save_images: 1
    }.freeze

    def initialize
      # dup створює копію
      @config = DEFAULT_CONFIG.dup
      @logger = MyApplicationLevitskii::LoggerManager.setup
    end

    def configure(overrides = {})
      overrides.each do |key, value|
        if @config.key?(key)
          @config[key] = value
        else
          @logger.info("Invalid configuration key #{key}")
        end
      end
    end

    def execute(parser: nil, collection: nil, output_dir: nil)
      @config.each do |key, value|
        next unless value == 1

        case key
        when :run_website_parser
          @logger.info('Website parsing started')
          raise 'Parser is not provided!' if parser.nil?
          items = parser.parse_page
          # Кожну item додаємо в колекцію
          items.each { |item| collection.add_item(item) }
        when :run_save_to_csv
          collection.save_to_csv("#{output_dir}/items.csv")
          @logger.info('Data is save into csv file')
        when :run_save_to_json
          collection.save_to_json("#{output_dir}/items.json")
          @logger.info('Data is save into json file')
        when :run_save_to_yaml
          collection.save_to_yml("#{output_dir}/items.yml")
          @logger.info('Data is save into yml file')
        when :run_save_to_sqlite
          collection.save_to_sqlite("#{output_dir}/items.sqlite")
          @logger.info('Data is save into sqlite file')
        when :run_save_images
          collection.save_images("#{output_dir}/media")
          @logger.info("Images are saved in #{output_dir}/media")
        else
          @logger.info("Invalid action #{key}")
        end
      end
    end
  end
end
