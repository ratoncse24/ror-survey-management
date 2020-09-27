class QuestionWithAnswerSerializer < ActiveModel::Serializer
  attributes :id, :question_title

  has_many :answers, :serializer => AnswerSerializer
end
