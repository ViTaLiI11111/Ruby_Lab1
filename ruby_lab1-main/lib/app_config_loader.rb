# frozen_string_literal: true

require 'yaml'
require 'erb'

module MyApplicationLevitskii
  # Клас для завантаження конфігураційних файлів у проекті.
  # Містить методи для завантаження конфігурацій:
  # 1. Загальна конфігурація (default_config.yaml)
  # 2. Конфігурація парсера сайту (config.yml)
  # 3. Конфігурація для логування (logging_config.yaml)
  class AppConfigLoader
    def self.load_config
      file_path = File.join(File.dirname(__FILE__), '../config/default_config.yaml')
      YAML.load(ERB.new(File.read(file_path)).result)
    end

    def self.load_web_parser_config
      file_path = File.join(File.dirname(__FILE__), '../config/config.yml')
      YAML.load(ERB.new(File.read(file_path)).result)
    end

    def self.load_logging_config
      file_path = File.join(File.dirname(__FILE__), '../config/logging_config.yaml')
      YAML.load(ERB.new(File.read(file_path)).result)
    end
  end
end
