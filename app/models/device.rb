class Device < ApplicationRecord
  has_many :users, primary_key: :user_guid, foreign_key: :guid
  
  def send_notification(options={alert: "Sample Message"})
    options = { alert: options } if options.is_a?(String)
    if self.os == "ios"
      APNS.send_notification(self.token, options)
    elsif self.os == "android"
      data = { notification: { body: options[:alert], title: options[:title] } }
      GCM.send_notification(self.token, data)
    end
  end
end
