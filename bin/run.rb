# frozen_string_literal: true

require_relative 'environment'

Scraper.new(@db).scrape

all_pokemon = @db.execute('SELECT * FROM pokemon;')

# test out your code here!
p Pokemon.find(151, @db).name
