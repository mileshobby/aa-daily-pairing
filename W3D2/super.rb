class ModelBase

  def self.find_by_id(id)
    obj = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table}
      WHERE
        id = ?
    SQL
    self.new(obj.first)
  end

  def self.all
    objs = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      #{table}
    SQL
    objs.map { |obj| self.new(obj) }
  end


end
