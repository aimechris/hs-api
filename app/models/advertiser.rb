class Advertiser < ApplicationRecord
  before_create :confirmation_token
  # encrypt password
  has_secure_password
  # Associations
  has_many :listings, foreign_key: :created_by

  # Validations
  validates_presence_of :first_name, :last_name, :phone, :address, :email, :password

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRadom.urlsafe_base64.to_s
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at =Time.zone.now
    save!
    AdvertiserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRadom.urlsafe_base64
    end while Advertiser.exists?(column => self[column])
  end
