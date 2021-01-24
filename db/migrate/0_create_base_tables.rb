class CreateBaseTables < ActiveRecord::Migration[5.2]

  def change
    create_table :jobs do |t|
      t.string :job_title
      t.string :url
      t.float :wage_hour
      t.float :wage_year
      t.string :education
      t.integer :num_posts
    end

  end

end
