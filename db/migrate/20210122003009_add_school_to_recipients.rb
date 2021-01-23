class AddSchoolToRecipients < ActiveRecord::Migration[6.0]
  def change
    add_reference :recipients, :school
  end
end
