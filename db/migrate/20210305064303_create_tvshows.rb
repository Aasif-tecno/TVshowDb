class CreateTvshows < ActiveRecord::Migration[6.1]
  def change
    create_table :tvshows do |t|
      t.string :name
      t.string :crew
      t.decimal :season

      t.timestamps
    end
  end
end
