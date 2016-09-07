class User < ApplicationRecord
  before_save :unique_codename
  has_many :answers, class_name: "SurveyAnswer", dependent: :destroy
  has_many :devices, primary_key: :guid, foreign_key: :user_guid
  has_many :other_users, class_name: "User", primary_key: :guid, foreign_key: :guid

  def self.generate_codename
    self.new.generate_codename
  end
  
  def generate_codename
    /\w{4,6}+/.gen.capitalize + /\w{4,6}+/.gen.capitalize
  end

  def unique_codename
    if not self.codename
      candidate = self.generate_codename
      while self.class.where(codename: candidate).first != nil
        candidate = self.generate_codename
      end
      self.codename = candidate
    end
  end

  def regen_codename
    self.codename = nil
    self.save
  end

  def send_notification(options={ alert: "A random alert", sound: "default", badge: 42 })
    devices.each do |device|
      device.send_notification(options)
    end
  end
end
