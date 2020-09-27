class QuestionWithChoiceSerializer < ActiveModel::Serializer
  attributes :id, :question_title, :option_type

  has_many :choices
end
