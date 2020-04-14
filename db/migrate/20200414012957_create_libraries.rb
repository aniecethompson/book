class CreateLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.string :title
      t.string :author
      t.string :publisher
    end
  end
end
