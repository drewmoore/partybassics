require 'sqlite3'

class Database < SQLite3::Database
  def initialize(database)
    super(database)
    self.results_as_hash = true
  end
  def self.connection(environment)
    @connection ||= Database.new("db/iching_#{environment}.sqlite3")
  end
  def create_table(table)
    self.execute("CREATE TABLE #{table}
                 (id INTEGER PRIMARY KEY AUTOINCREMENT)")
  end
  def table_exists? table
    begin
      self.execute("SELECT * FROM " + table)
    rescue
      return false
    end
    return true
  end
  def execute(statement, bind_vars = [])
    Environment.logger.info("Executing: " + statement)
    super(statement, bind_vars)
  end
end
