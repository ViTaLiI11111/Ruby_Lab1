# frozen_string_literal: true

require 'logger'
require 'faker'

module MyApplicationLevitskii

  class Item
    attr_accessor :name, :price, :description, :category, :image_path, :rating, :availability, :details_link


    def initialize(attributes = {})
      @name = attributes[:name]
      @price = attributes[:price]
      @description = attributes[:description]
      @category = attributes[:category]
      @image_path = attributes[:image_path]
      @rating = attributes[:rating]
      @availability = attributes[:availability]
      @details_link = attributes[:details_link]

      yield(self) if block_given?
    end

    def to_s
      instance_variables.map { |var| "#{var}: #{instance_variable_get(var)}" }.join(',')
    end

    def to_h
      instance_variables.each_with_object({}) do |var, hash|
        hash[var.to_s.delete('@')] = instance_variable_get(var)
      end
    end

    def inspect
      "#<Item name: #{@name}, price: #{@price}>, description: #{@description}, rating: #{@rating}"
    end

    def update
      yield(self) if block_given?
    end

    def self.generate_fake
      new(
        name: Faker::Commerce.product_name,
        price: Faker::Commerce.price(range: 10..100).to_s,
        description: Faker::Lorem.sentence,
        category: Faker::Commerce.department,
        image_path: Faker::LoremPixel.image,
        rating: %w[One Two Three Four Five].sample,
        availability: 'In stock',
        details_link: Faker::Internet.url
      )
    end
  end
end
