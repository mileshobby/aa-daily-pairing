require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns unless @columns.nil?
    cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT
        0
    SQL
    @columns = cols.first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column|
      define_method(column) { attributes[column] }
      define_method("#{column}=") { |val| attributes[column] = val }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || to_s.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    parse_all(results)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL
    result.empty? ? nil : self.new(result.first)
  end

  def initialize(params = {})
    params.each do |attr_name, val|
      unless self.class.columns.include?(attr_name.to_sym)
        raise "unknown attribute '#{attr_name}'"
      end
      send("#{attr_name}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |col| send(col) }
  end

  def insert
    col_names = self.class.columns.join(', ')
    question_marks = (['?'] * self.class.columns.length).join(', ')
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    send('id=', DBConnection.last_insert_row_id)
  end

  def update
    #sdebugger
    cols = self.class.columns - [:id]
    #remove id from front of attribute_values since we don't update that
    attrs = attribute_values.drop(1) + [self.id]
    set_cols = cols.join(' = ?, ') + ' = ?'
    DBConnection.execute(<<-SQL, *attrs)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_cols}
      WHERE
        id = ?
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
