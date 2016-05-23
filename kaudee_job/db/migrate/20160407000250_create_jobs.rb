class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :homepage
      t.string :email
      t.string :city
      t.string :district
      t.string :tel
      t.string :tel2
      t.string :mobile
      t.string :fax
      t.integer :user_id
      
      t.string :address
      t.string :address_lao
      t.string :cellphone
      
      t.string :latitude
      t.string :longitude
      t.string :delyn
      
      t.string :jobTitle
      t.string :jobTitle_lao
      
      t.string :companyname
      t.string :companyname_lao
      
      t.string :postedDate
      t.string :category1
      t.string :category2
      
      t.string :skills
      t.string :skills_lao
      t.string :jobType
      t.string :minSalary
      t.string :minSalary_unit
      t.string :salaryType
      
      t.string :description
      t.string :description_lao
      t.string :requirements
      t.string :requirements_lao

      t.timestamps null: false
    end
  end
end
