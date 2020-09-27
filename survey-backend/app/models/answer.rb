class Answer < ApplicationRecord
  # validations
  validates_presence_of :question_id, :answer_text

  # model relationships
  belongs_to :question
end
