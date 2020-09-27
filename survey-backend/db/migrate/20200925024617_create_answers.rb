class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers, comment: 'store question answer' do |t|
      t.references :question, index: true, foreign_key: true
      t.string :answer_text
      t.timestamps
    end
  end
end
