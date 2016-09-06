class Device < ApplicationRecord
  has_many :users, primary_key: :user_guid, foreign_key: :guid
  
  def send_notification(options={})
    options = { alert: options } if options.is_a?(String)
    APNS.send_notification(self.token, options)
  end
end
