class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :description
      t.integer :answers_count, default: 0, null: false
      t.string :slug
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
