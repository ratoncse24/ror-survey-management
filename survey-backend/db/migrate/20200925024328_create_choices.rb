class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices, comment: 'store question choices' do |t|
      t.references :question, index: true, foreign_key: true
      t.string :choice_title
      t.integer :next_question_id, null:true
      t.timestamps
    end
  end
end
