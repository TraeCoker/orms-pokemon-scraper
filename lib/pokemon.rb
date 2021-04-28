class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id 

    def initialize(name:, type:, db:, id: nill)
        @name = name
        @type = type 
        @db = db 
        @id = id
    end 

    def self.save(name, type, db) 
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL
    
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"

    result = db.execute(sql, id).first
    self.new(name: result[1], type: result[2], db: db, id: id)
  end 

end
