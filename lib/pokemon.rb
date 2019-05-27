class Pokemon
    attr_accessor :name, :type
    attr_reader :id, :db, :hp

    def initialize(id: nil, name:, type:, db:, hp: nil)
        @id, @name, @type, @db, @hp = id, name, type, db, hp
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end
    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon 
            WHERE id = ?
        SQL
        args = db.execute(sql, id).first
        Pokemon.new(id: args[0], name: args[1], type: args[2], db: db, hp: args[3]) 
    end

    def alter_hp(hp, db)
        sql = <<-SQL
            UPDATE pokemon SET hp = ? WHERE name = ?
        SQL
        db.execute(sql, hp, self.name)
    end
end
