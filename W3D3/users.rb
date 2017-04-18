require 'sqlite3'
require 'singleton'
require_relative 'questions'
require_relative 'follows'

class User < ModelBase
  attr_accessor :fname, :lname

  # def self.find_by_id(id)
  #   user = QuestionsDatabase.instance.execute(<<-SQL, id)
  #     SELECT
  #       *
  #     FROM
  #       users
  #     WHERE
  #       id = ?
  #   SQL
  #   User.new(user.first)
  # end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND
        lname = ?
    SQL
    User.new(user.first)
  end

  def self.table
    'users'
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    Follow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    Like.liked_questions_for_user_id(@id)
  end

  def average_karma
    karma = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      AVG(Num_Likes) AS Avg
    FROM
      (SELECT
        COUNT(*) AS Num_Likes
      FROM
        question_likes
      WHERE
        question_id IN (
          SELECT
            id
          FROM
            questions
          WHERE
            user_id = ?
        )
      GROUP BY
        question_id
      );
    SQL
    karma.first['Avg']
  end

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?,?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
      SQL
    end
  end

end
