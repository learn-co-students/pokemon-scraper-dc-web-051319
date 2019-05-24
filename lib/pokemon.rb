require "pry"
class Pokemon

    attr_accessor :name,:type,:db,:id,:hp_value

    def initialize(id=nil)
        @id = id
        # @hp_value = 60
    end

    # def initialize(id:, name:, type:, hp: 60, db: )
    #     @id, @name, @type, @hp, @db = id, name, type, hp, db
    # end

    def self.save(name,type,db)
        sql = <<-SQL
            INSERT INTO pokemon (name,type) VALUES (?, ?)
        SQL
        db.execute(sql,name,type)
    end

    def self.find(id,db)
        sql = <<-SQL
            SELECT * FROM pokemon WHERE id = ? LIMIT 1
        SQL
        row = db.execute(sql,id).first
        self.row_to_object(row)
    end

    def self.row_to_object(row)
        # pokemon = Pokemon.new(id: row[0], name: row[1], type: row[2], db:db)
        pokemon = Pokemon.new
        pokemon.id = row[0]
        pokemon.name = row[1]
        pokemon.type = row[2]
        return pokemon
    end

    # def alter_hp(new_hp, db)
    #     # binding.pry
    #     db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, self.id)
    # end

end
