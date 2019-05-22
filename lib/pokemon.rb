# frozen_string_literal: true

require 'pry'

require_relative '../bin/environment'

class Pokemon
  attr_reader :id
  attr_accessor :name, :type, :db, :hp

  def initialize(id: nil, name:, type:, db:, hp: 60)
    @id = id
    @name = name
    @db = db
    @type = type
    @hp = hp
  end

  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon(name, type)
    VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
    SELECT *
    FROM pokemon
    WHERE id = ?
    LIMIT 1
    SQL

    row = db.execute(sql, id).first
    Pokemon.new(id: row[0], name: row[1], type: row[2], db: db, hp: row[3])
  end

  def alter_hp(num, db)
    sql = <<-SQL
    UPDATE pokemon
    SET hp = ?
    WHERE id = ?
    SQL

    db.execute(sql, num, id)
    p Pokemon.find(1, db)
  end
end
