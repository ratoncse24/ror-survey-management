class SurveyQuestionWithAnswerSerializer < ActiveModel::Serializer
  attributes :id, :survey_title, :created_at

  has_many :questions, :serializer => QuestionWithAnswerSerializer

end