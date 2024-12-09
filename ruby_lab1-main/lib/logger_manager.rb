# frozen_string_literal: true

require 'logger'

module MyApplicationLevitskii
  class LoggerManager
    def self.setup
      config = AppConfigLoader.load_logging_config
      directory = config["logging"]["directory"]
      level = eval("Logger::#{config['logging']['level']}")
      logger = Logger.new(File.join(directory, config['logging']['files']['application_log']))
      logger.level = level
      logger
    end
    # def self.setup
    #   # Завантажуємо конфігурації для логера
    #   config = AppConfigLoader.load_logging_config
    #   # Шлях де будуть зберігатися логи
    #   directory = config['logging']['directory']
    #   # Встановлюється рівень логування
    #   level = eval("Logger::#{config['logging']['level']}")
    #   logger = Logger.new(File.join(directory, config['logging']['files']['application_log']))
    #   logger.level = level
    #   logger
    # end
  end
end
