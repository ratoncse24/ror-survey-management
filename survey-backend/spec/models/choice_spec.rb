require 'rails_helper'

RSpec.describe Choice, type: :model do
  # Association test
  # ensure an Choice record belongs to a single Question record
  it { should belong_to(:question) }
  # Validation tests
  # ensure columns choice_title and question_id present before saving
  it { should validate_presence_of(:choice_title) }
  it { should validate_presence_of(:question_id) }
end
