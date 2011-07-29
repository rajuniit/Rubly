class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :long_url
      t.string :short_url
      t.string :ip_address
      t.integer :total_click

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
