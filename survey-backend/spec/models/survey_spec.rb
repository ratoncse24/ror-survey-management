require 'rails_helper'

RSpec.describe Survey, type: :model do
  # Association test
  # ensure Survey model has a 1:m relationship with the Question model
  it { should have_many(:questions).dependent(:destroy) }
  # Validation tests
  # ensure columns survey_title present before saving
  it { should validate_presence_of(:survey_title) }
end
