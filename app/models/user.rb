# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :previous_emails, dependent: :destroy

  before_update :persist_user_emails, if: :will_save_change_to_email?
  validates_uniqueness_of :email

  def persist_user_emails
    previous_emails.build(email: email_before_last_save)
  end
end
