class SurveySerializer < ActiveModel::Serializer
  attributes :id, :survey_title, :created_at
end