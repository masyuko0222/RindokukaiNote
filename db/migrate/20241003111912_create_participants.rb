class CreateParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :participants do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :reading_club, null: false, foreign_key: true

      t.timestamps
    end
  end
end
