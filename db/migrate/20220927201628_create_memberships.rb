class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships do |t|
      t.string :beer_club_id
      t.string :user_id

      t.timestamps
    end
  end
end
