class CreateAsynapseFiles < ActiveRecord::Migration
  def self.up
    create_table :asynapse_files do |t|
      t.column :name, :string
      t.column :content, :string
    end
  end

  def self.down
    drop_table :asynapse_files
  end
end
