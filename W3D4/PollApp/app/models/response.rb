class Response < ApplicationRecord
  validates :user_id, :choice_id, presence: true

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :choice_id,
    class_name: "AnswerChoice"

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    question.responses.where.not('responses.id = ?', self.id)
  end
end
