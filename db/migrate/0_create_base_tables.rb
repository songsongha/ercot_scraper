class CreateBaseTables < ActiveRecord::Migration[5.2]

    def change
        create_table :prizes do |t|
            t.string :date
            t.float :m7_payout
            t.float :m6bonus_payout
            t.float :m6_payout
            t.float :m5bonus_payout
            t.float :m5_payout
            t.float :m4bonus_payout
            t.float :m4_payout
            t.float :m3bonus_payout
            t.string :m3_payout
            t.integer :num_posts
        end

        create_table :results do |t|
            t.string :date
            t.integer :pos1
            t.integer :pos2
            t.integer :pos3
            t.integer :pos4
            t.integer :pos5
            t.integer :pos6
            t.integer :pos7
            t.integer :bonus
            t.references :prize
            t.references :result
        
        end

        create_table :max_millions do |t|
            t.string :date
            t.integer :pos1
            t.integer :pos2
            t.integer :pos3
            t.integer :pos4
            t.integer :pos5
            t.integer :pos6
            t.integer :pos7
            t.references :prize
            t.references :result
        end
    end

end
