class User < ApplicationRecord
  before_save :unique_codename
  has_many :answers, class_name: "SurveyAnswer", dependent: :destroy

  def self.generate_codename
    self.new.generate_codename
  end
  
  def generate_codename
    /\w+/.gen.capitalize + /\w+/.gen.capitalize
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
end
