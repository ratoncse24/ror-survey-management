class Choice < ApplicationRecord
  # validations
  validates_presence_of :choice_title, :question_id

  # model relationships
  belongs_to :question
end
