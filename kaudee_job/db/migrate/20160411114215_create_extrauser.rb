class Extrausers < ActiveRecord::Migration
  def change
    create_table :extrausers do |t|
      t.string :postedDate
      t.string :category1
      t.string :category2
      t.string :skills
      t.string :skills_lao
      t.string :jobType
      t.string :minSalary
      t.string :minSalary_unit
      t.string :salaryType
      
      t.string :resume
      t.string :resume_lao
      t.string :coverLetter
      t.string :coverLetter_lao
      
      t.string :city
      t.string :district
      
      t.timestamps null: false
    end
  end
end
