class Survey < ApplicationRecord
  # validations
  validates_presence_of :survey_title

  # model relationships
  has_many :questions, dependent: :destroy
end
