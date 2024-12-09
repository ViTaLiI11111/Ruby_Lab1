# frozen_string_literal: true

require 'sqlite3'

module MyApplicationLevitskii
  class DatabaseConnector
    attr_reader :db

    def initialize(database_path)
      @db = SQLite3::Database.new(database_path)
      create_table
    end

    def create_table
      @db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS items (
          id INTEGER PRIMARY KEY,
          name TEXT,
          price REAL,
          description TEXT,
          rating TEXT,
          details_link TEXT
        );
      SQL
    end

    def save_item(item)
      @db.execute(
        'INSERT INTO items (name, price, description) VALUES (?, ?, ?)',
        [item[:name], item[:price], item[:description]]
      )
    end

    # & перевіряє чи об'єкт nil,
    def close
      @db.close
    end
  end
end
