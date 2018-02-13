class CreatePreviousEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :previous_emails do |t|
      t.string :email
      t.references :user, foreign_key: true
    end
    add_index :previous_emails, :email, unique: true
  end
end
