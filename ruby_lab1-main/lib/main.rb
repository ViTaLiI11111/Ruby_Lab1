# frozen_string_literal: true

require_relative 'app_config_loader'
require_relative 'simple_website_parser'
require_relative 'item_collection'
require_relative 'configurator'

begin
  puts 'Програму розпочато'
  parser = MyApplicationLevitskii::SimpleWebsiteParser.new
  collection = MyApplicationLevitskii::ItemCollection.new

  output_dir = File.join(File.dirname(__FILE__), '../output')

  configurator = MyApplicationLevitskii::Configurator.new
  configurator.configure

  configurator.execute(parser: parser, collection: collection, output_dir: output_dir)

  puts 'Програму закінчено'
rescue StandardError => e
  puts "Виникла помилка: #{e.message}"
  puts e.backtrace.join("\n")
end
