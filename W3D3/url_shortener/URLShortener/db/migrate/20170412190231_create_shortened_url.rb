class CreateShortenedUrl < ActiveRecord::Migration[5.0]
  def change
    create_table :shortened_urls do |t|
      t.string :short_url
      t.string :long_url
      t.integer :user_id

      t.timestamps
    end

    add_index :shortened_urls, :short_url, unique: true
  end
end
