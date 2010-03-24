class CreateCritics < ActiveRecord::Migration
  def self.up
    create_table :critics do |t|
      t.integer :user_id
      t.integer :movie_id
      t.text :content
      t.integer :score

      t.timestamps
    end
  end

  def self.down
    drop_table :critics
  end
end
