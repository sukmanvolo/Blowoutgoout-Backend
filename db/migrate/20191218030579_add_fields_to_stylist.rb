class AddFieldsToStylist < ActiveRecord::Migration[5.2]
  def change
    add_column :stylists, :years_of_experience, :integer, default: 0
    add_column :stylists, :license_agreement, :boolean
    add_column :stylists, :has_smartphone, :integer, default: 0
    add_column :stylists, :has_transportation, :boolean
    add_column :stylists, :portfolio_link, :string
    add_column :stylists, :is_eligible_to_work_in_us, :boolean, default: false
    add_column :stylists, :previous_contractor_date, :date
    add_column :stylists, :has_conviction, :boolean
    add_column :stylists, :agrees_to_unemployment_understanding, :boolean
    add_column :stylists, :agrees_to_taxation_understanding, :boolean
  end
end
