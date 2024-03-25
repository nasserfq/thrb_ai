class User < ApplicationRecord
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  passwordless_with :email # <-- here!
  #Nasser:From ChatGPT
  has_many :tasks, dependent: :destroy  # Corrected association


  def self.fetch_resource_for_passwordless(email)
    find_or_create_by(email:)
  end
end
