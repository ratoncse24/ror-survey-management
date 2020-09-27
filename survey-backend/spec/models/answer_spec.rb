require 'rails_helper'

RSpec.describe Answer, type: :model do
  # Association test
  # ensure an Anser record belongs to a single Question record
  it { should belong_to(:question) }
  # Validation tests
  # ensure columns answer_text and question_id present before saving
  it { should validate_presence_of(:answer_text) }
  it { should validate_presence_of(:question_id) }
end
