require 'rails_helper'

RSpec.describe Question, type: :model do
  # Association test
  # ensure an Question record belongs to a single Survey record
  it { should belong_to(:survey) }
  # ensure Question model has a 1:m relationship with the Choices model
  it { should have_many(:choices).dependent(:destroy) }
  # ensure Question model has a 1:m relationship with the Answer model
  it { should have_many(:answers) }
  # Validation tests
  # ensure columns question_title and survey_id present before saving
  it { should validate_presence_of(:question_title) }
  it { should validate_presence_of(:survey_id) }

  # validate question_type enum column with the accepted options
  it { should allow_values(:input_text, :multiple_choice, :single_choice).for(:option_type) }
end
