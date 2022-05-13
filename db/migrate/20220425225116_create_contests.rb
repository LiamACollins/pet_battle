class CreateContests < ActiveRecord::Migration[7.0]
  def change
    create_table :contests do |t|
      t.string :first_contestant_id
      t.string :second_contestant_id
      t.string :status
      t.string :contest_type
      t.string :winner_id

      t.timestamps
    end
  end
end
