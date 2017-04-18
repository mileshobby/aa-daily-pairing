require 'sqlite3'
require 'singleton'
require_relative 'questions'

class Reply < ModelBase
  attr_accessor :body, :user_id, :question_id, :parent_id

  # def self.find_by_id(id)
  #   reply = QuestionsDatabase.instance.execute(<<-SQL, id)
  #     SELECT
  #       *
  #     FROM
  #       replies
  #     WHERE
  #       id = ?
  #   SQL
  #   Reply.new(reply.first)
  # end

  def self.table
    'replies'
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
    SQL
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL
    replies.map { |reply| Reply.new(reply) }
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    children = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id = ?
    SQL
    children.map { |child| Reply.new(child) }
  end

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, body, user_id, question_id, parent_id)
      INSERT INTO
        replies (body, user_id, question_id, parent_id)
      VALUES
        (?,?,?,?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, body, user_id, question_id, parent_id, @id)
      UPDATE
        replies
      SET
        body = ?, user_id = ?, question_id = ?, parent_id = ?
      WHERE
        id = ?
      SQL
    end
  end

end
