class Question < ApplicationRecord
  enum option_type: { input_text: 'input_text',
                      single_choice: 'single_choice',
                      multiple_choice: 'multiple_choice' }

  # validations
  validates_presence_of :question_title, :survey_id
  validates :option_type, inclusion: { in: option_types.keys }

  # model relationships
  belongs_to :survey
  has_many :choices , dependent: :destroy
  has_many :answers

end
